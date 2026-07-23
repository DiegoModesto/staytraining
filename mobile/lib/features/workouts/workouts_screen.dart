import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  ConsumerState<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends ConsumerState<WorkoutsScreen> {
  late Future<List<WorkoutListItem>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() => setState(() => _future = ref.read(trainingApiProvider).listWorkouts());

  Future<void> _createFromTemplate() async {
    final api = ref.read(trainingApiProvider);
    final templates = await api.listTemplates();
    if (!mounted) return;

    final chosen = await showModalBottomSheet<WorkoutTemplateListItem>(
      context: context,
      showDragHandle: true,
      builder: (c) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: templates
              .map((t) => ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: Text(t.name),
                    subtitle: Text('${t.itemCount} exercícios${t.isSystemDefault ? ' • padrão' : ''}'
                        '${t.modalityName != null ? ' • ${t.modalityName!}' : ''}'),
                    onTap: () => Navigator.pop(c, t),
                  ))
              .toList(),
        ),
      ),
    );
    if (chosen == null) return;

    try {
      // Empty owner id => the API assigns the workout to the current user (student self-service).
      await api.createWorkoutFromTemplate(chosen.id, _emptyGuid);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Treino criado a partir do modelo.')));
      _reload();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha: $e')));
    }
  }

  static const _emptyGuid = '00000000-0000-0000-0000-000000000000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus treinos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createFromTemplate,
        icon: const Icon(Icons.content_copy),
        label: const Text('De um modelo'),
      ),
      body: FutureBuilder<List<WorkoutListItem>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Falha ao carregar: ${snap.error}'));
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Nenhum treino ainda. Crie um a partir de um modelo.'));
          }
          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView(
              children: [
                AdaptiveContainer(
                  child: AdaptiveCardGrid(
                    children: [
                      for (final w in items)
                        Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            leading: const Icon(Icons.fitness_center),
                            title: Text(w.name),
                            subtitle: Text('${w.itemCount} exercícios${w.modalityName != null ? ' • ${w.modalityName!}' : ''}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.go('/workouts/${w.id}'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
