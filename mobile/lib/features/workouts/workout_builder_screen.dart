import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

/// A prescription entry being assembled locally before the workout is saved.
/// Strength entries carry sets/reps/rest; interval (aerobic) entries carry work/rest/rounds.
class DraftWorkoutItem {
  DraftWorkoutItem({
    required this.exercise,
    required this.isInterval,
    this.sectionLabel,
    this.sets,
    this.reps,
    this.restSeconds,
    this.workSeconds,
    this.intervalRestSeconds,
    this.rounds,
  });

  /// Seeds a draft from the exercise's own default prescription.
  factory DraftWorkoutItem.fromExercise(Exercise e) => e.isAerobic
      ? DraftWorkoutItem(
          exercise: e,
          isInterval: true,
          restSeconds: e.defaultRestSeconds,
          workSeconds: e.defaultWorkSeconds ?? 40,
          intervalRestSeconds: e.defaultIntervalRestSeconds ?? 20,
          rounds: e.defaultRounds ?? 8,
        )
      : DraftWorkoutItem(
          exercise: e,
          isInterval: false,
          sets: e.defaultSets,
          reps: e.defaultReps,
          restSeconds: e.defaultRestSeconds,
        );

  final Exercise exercise;
  bool isInterval;
  String? sectionLabel;
  int? sets;
  int? reps;
  int? restSeconds;
  int? workSeconds;
  int? intervalRestSeconds;
  int? rounds;

  /// Maps to the API `WorkoutItemInput` contract (camelCase). `order` is the position in the list.
  Map<String, dynamic> toJson(int order) => {
        'exerciseId': exercise.id,
        'order': order,
        'sectionLabel': sectionLabel,
        'sets': isInterval ? 1 : (sets ?? 3),
        'reps': isInterval ? 0 : (reps ?? 10),
        'restSeconds': restSeconds ?? 60,
        'durationSeconds': null,
        'workSeconds': isInterval ? (workSeconds ?? 40) : null,
        'intervalRestSeconds': isInterval ? (intervalRestSeconds ?? 20) : null,
        'rounds': isInterval ? (rounds ?? 8) : null,
        'professorComment': null,
      };

  String get summary => isInterval
      ? '${workSeconds ?? 40}s on / ${intervalRestSeconds ?? 20}s off × ${rounds ?? 8}'
      : '${sets ?? 3}×${reps ?? 10} • ${restSeconds ?? 60}s descanso';
}

/// Student self-service: build a workout from scratch by picking exercises and their prescription.
class WorkoutBuilderScreen extends ConsumerStatefulWidget {
  const WorkoutBuilderScreen({super.key});

  @override
  ConsumerState<WorkoutBuilderScreen> createState() => _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends ConsumerState<WorkoutBuilderScreen> {
  static const _emptyGuid = '00000000-0000-0000-0000-000000000000';

  final _nameController = TextEditingController();
  Modality? _modality;
  final List<DraftWorkoutItem> _items = [];
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickModality() async {
    final modalities = await ref.read(trainingApiProvider).listModalities();
    if (!mounted) return;
    final chosen = await showModalBottomSheet<Modality?>(
      context: context,
      showDragHandle: true,
      builder: (c) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Sem modalidade'),
              onTap: () => Navigator.pop(c, null),
            ),
            for (final m in modalities)
              ListTile(
                leading: const Icon(Icons.category_outlined),
                title: Text(m.name),
                onTap: () => Navigator.pop(c, m),
              ),
          ],
        ),
      ),
    );
    // Distinguish "picked none" from "dismissed": only update when a tile was tapped.
    if (!mounted) return;
    setState(() => _modality = chosen);
  }

  Future<void> _addExercise() async {
    final exercises = await ref.read(trainingApiProvider).listExercises(
          modalityId: _modality?.id,
        );
    if (!mounted) return;
    final chosen = await showModalBottomSheet<Exercise>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (c) => _ExercisePicker(exercises: exercises),
    );
    if (chosen == null || !mounted) return;
    final draft = DraftWorkoutItem.fromExercise(chosen);
    final edited = await _editItem(draft);
    if (edited == null || !mounted) return;
    setState(() => _items.add(edited));
  }

  Future<DraftWorkoutItem?> _editItem(DraftWorkoutItem draft) => showDialog<DraftWorkoutItem>(
        context: context,
        builder: (c) => _ItemEditorDialog(draft: draft),
      );

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dê um nome ao treino.')));
      return;
    }
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicione ao menos um exercício.')));
      return;
    }
    setState(() => _saving = true);
    try {
      final body = {
        'ownerStudentId': _emptyGuid, // empty => API assigns to the current user
        'name': name,
        'description': null,
        'modalityId': _modality?.id,
        'items': [for (var i = 0; i < _items.length; i++) _items[i].toJson(i)],
      };
      final id = await ref.read(trainingApiProvider).createWorkout(body);
      if (!mounted) return;
      context.go('/workouts/$id');
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao criar treino: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo treino'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/workouts'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saving ? null : _save,
        icon: _saving
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.check),
        label: const Text('Salvar'),
      ),
      body: AdaptiveContainer(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Nome do treino',
                hintText: 'Ex.: Treino A — Peito e tríceps',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickModality,
              icon: const Icon(Icons.category_outlined),
              label: Text(_modality?.name ?? 'Modalidade (opcional)'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Exercícios', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Text('${_items.length}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            if (_items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('Nenhum exercício ainda. Toque em "Adicionar exercício".')),
              )
            else
              ..._items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Card(
                  key: ValueKey(item),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text(item.exercise.name),
                    subtitle: Text(item.summary),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: 'Editar',
                          onPressed: () async {
                            final edited = await _editItem(item);
                            if (edited != null) setState(() => _items[i] = edited);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Remover',
                          onPressed: () => setState(() => _items.removeAt(i)),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: _addExercise,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar exercício'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Searchable list of exercises to add to the workout.
class _ExercisePicker extends StatefulWidget {
  const _ExercisePicker({required this.exercises});

  final List<Exercise> exercises;

  @override
  State<_ExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends State<_ExercisePicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.exercises
        : widget.exercises
            .where((e) => e.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar exercício',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('Nenhum exercício encontrado.'))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (c, i) {
                          final e = filtered[i];
                          return ListTile(
                            leading: Icon(e.isAerobic ? Icons.directions_run : Icons.fitness_center),
                            title: Text(e.name),
                            subtitle: Text(e.modalityName),
                            onTap: () => Navigator.pop(c, e),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Edits the prescription (sets/reps/rest or work/rest/rounds) of a single draft item.
class _ItemEditorDialog extends StatefulWidget {
  const _ItemEditorDialog({required this.draft});

  final DraftWorkoutItem draft;

  @override
  State<_ItemEditorDialog> createState() => _ItemEditorDialogState();
}

class _ItemEditorDialogState extends State<_ItemEditorDialog> {
  late final DraftWorkoutItem _d;
  late final TextEditingController _section;

  @override
  void initState() {
    super.initState();
    // Edit a copy so cancelling leaves the original untouched.
    final o = widget.draft;
    _d = DraftWorkoutItem(
      exercise: o.exercise,
      isInterval: o.isInterval,
      sectionLabel: o.sectionLabel,
      sets: o.sets,
      reps: o.reps,
      restSeconds: o.restSeconds,
      workSeconds: o.workSeconds,
      intervalRestSeconds: o.intervalRestSeconds,
      rounds: o.rounds,
    );
    _section = TextEditingController(text: o.sectionLabel ?? '');
  }

  @override
  void dispose() {
    _section.dispose();
    super.dispose();
  }

  Widget _number(String label, int? value, ValueChanged<int?> onChanged) => TextFormField(
        initialValue: value?.toString() ?? '',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: (v) => onChanged(int.tryParse(v)),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_d.exercise.name),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _section,
              decoration: const InputDecoration(labelText: 'Seção (opcional)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            if (_d.isInterval) ...[
              _number('Trabalho (s)', _d.workSeconds, (v) => _d.workSeconds = v),
              const SizedBox(height: 8),
              _number('Descanso (s)', _d.intervalRestSeconds, (v) => _d.intervalRestSeconds = v),
              const SizedBox(height: 8),
              _number('Rounds', _d.rounds, (v) => _d.rounds = v),
            ] else ...[
              _number('Séries', _d.sets, (v) => _d.sets = v),
              const SizedBox(height: 8),
              _number('Repetições', _d.reps, (v) => _d.reps = v),
              const SizedBox(height: 8),
              _number('Descanso (s)', _d.restSeconds, (v) => _d.restSeconds = v),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () {
            final s = _section.text.trim();
            _d.sectionLabel = s.isEmpty ? null : s;
            Navigator.pop(context, _d);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
