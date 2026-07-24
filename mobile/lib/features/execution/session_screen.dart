import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../core/util/ids.dart';
import '../../models/models.dart';
import 'interval_timer_widget.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key, required this.workoutId});
  final String workoutId;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _NoteDraft {
  final loadCtrl = TextEditingController();
  final commentCtrl = TextEditingController();
  bool pain = false;
  int? performedSets;
  int? performedReps;
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  Workout? _workout;
  String? _sessionId;
  bool _offline = false;
  bool _loading = true;
  String? _error;
  int _rating = 3;
  final _overallCtrl = TextEditingController();
  final Map<String, _NoteDraft> _drafts = {};
  final DateTime _startedAt = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final api = ref.read(trainingApiProvider);
    try {
      _workout = await api.getWorkout(widget.workoutId);
      for (final it in _workout!.items) {
        _drafts[it.id] = _NoteDraft();
      }
      try {
        _sessionId = await api.startSession(widget.workoutId);
      } catch (_) {
        _offline = true;
        _sessionId = newGuid();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  bool _hasNote(_NoteDraft d) =>
      d.loadCtrl.text.trim().isNotEmpty ||
      d.commentCtrl.text.trim().isNotEmpty ||
      d.pain ||
      d.performedSets != null ||
      d.performedReps != null;

  Map<String, dynamic> _noteBody(WorkoutItem item) {
    final d = _drafts[item.id]!;
    return {
      'workoutItemId': item.id,
      'exerciseId': item.exerciseId,
      'loadKg': double.tryParse(d.loadCtrl.text.replaceAll(',', '.')),
      'painFlag': d.pain,
      'painNote': null,
      'comment': d.commentCtrl.text.trim().isEmpty ? null : d.commentCtrl.text.trim(),
      'performedSets': d.performedSets,
      'performedReps': d.performedReps,
    };
  }

  Future<void> _finish() async {
    final api = ref.read(trainingApiProvider);
    if (_offline) {
      final notes = _workout!.items.map((it) {
        final d = _drafts[it.id]!;
        return {
          'id': newGuid(),
          'workoutItemId': it.id,
          'exerciseId': it.exerciseId,
          'loadKg': double.tryParse(d.loadCtrl.text.replaceAll(',', '.')),
          'painFlag': d.pain,
          'comment': d.commentCtrl.text.isEmpty ? null : d.commentCtrl.text,
          'performedSets': d.performedSets,
          'performedReps': d.performedReps,
          'createdAt': DateTime.now().toUtc().toIso8601String(),
        };
      }).toList();

      final session = {
        'id': _sessionId,
        'workoutId': widget.workoutId,
        'startedAt': _startedAt.toIso8601String(),
        'completedAt': DateTime.now().toUtc().toIso8601String(),
        'completionRating': _rating,
        'overallComment': _overallCtrl.text.isEmpty ? null : _overallCtrl.text,
        'notes': notes,
      };
      await ref.read(localStoreProvider).enqueueSession(session);
    } else {
      try {
        // Comments/loads are batched here (saved on finish), not per exercise.
        for (final it in _workout!.items) {
          if (_hasNote(_drafts[it.id]!)) {
            await api.upsertNote(_sessionId!, _noteBody(it));
          }
        }
        await api.completeSession(_sessionId!, _rating, _overallCtrl.text.isEmpty ? null : _overallCtrl.text);
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao concluir: $e')));
        return;
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Treino concluído! 💪')));
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Execução'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => context.go('/workouts/${widget.workoutId}'),
        ),
        actions: [if (_offline) const Padding(padding: EdgeInsets.all(16), child: Icon(Icons.cloud_off))],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Falha: $_error'))
              : _buildBody(),
      bottomNavigationBar: _loading || _error != null ? null : _buildFinishBar(),
    );
  }

  Widget _buildBody() {
    final w = _workout!;
    return ListView(
      children: [
        AdaptiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(w.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              ...w.items.map(_buildItem),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(WorkoutItem item) {
    final d = _drafts[item.id]!;
    final name = ref.watch(exerciseCatalogProvider).maybeWhen(
          data: (c) => c.nameFor(item.exerciseId),
          orElse: () => 'Exercício ${item.order}',
        );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.sectionLabel != null && item.sectionLabel!.isNotEmpty)
              Text(item.sectionLabel!.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1)),
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            if (item.professorComment != null && item.professorComment!.isNotEmpty)
              Text(item.professorComment!, style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            if (item.isInterval)
              IntervalTimerWidget(
                workSeconds: item.workSeconds!,
                restSeconds: item.intervalRestSeconds ?? 0,
                rounds: item.rounds!,
              )
            else
              Text('${item.sets} × ${item.reps} • descanso ${item.restSeconds}s'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: d.loadCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Carga (kg)', isDense: true),
                  ),
                ),
                const SizedBox(width: 12),
                Row(children: [
                  const Text('Dor'),
                  Switch(value: d.pain, onChanged: (v) => setState(() => d.pain = v)),
                ]),
              ],
            ),
            TextField(
              controller: d.commentCtrl,
              decoration: const InputDecoration(labelText: 'Comentário', isDense: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('Nota:'),
                Expanded(
                  child: Slider(
                    value: _rating.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: '$_rating',
                    onChanged: (v) => setState(() => _rating = v.round()),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _overallCtrl,
              decoration: const InputDecoration(labelText: 'Comentário geral', isDense: true),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _finish,
                icon: const Icon(Icons.check),
                label: const Text('Concluir treino'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
