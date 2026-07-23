import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  const WorkoutDetailScreen({super.key, required this.workoutId});
  final String workoutId;

  @override
  ConsumerState<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  late Future<Workout> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(trainingApiProvider).getWorkout(widget.workoutId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treino')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/session/${widget.workoutId}'),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Iniciar treino'),
      ),
      body: FutureBuilder<Workout>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Falha ao carregar: ${snap.error}'));
          }
          final w = snap.data!;
          final catalog = ref.watch(exerciseCatalogProvider);
          String nameFor(String id) => catalog.maybeWhen(data: (c) => c.nameFor(id), orElse: () => 'Exercício');

          final sections = <String, List<WorkoutItem>>{};
          for (final it in w.items) {
            sections.putIfAbsent(it.sectionLabel ?? 'Exercícios', () => []).add(it);
          }

          return ListView(
            children: [
              AdaptiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(w.name, style: Theme.of(context).textTheme.headlineSmall),
                    if (w.description != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(w.description!)),
                    const SizedBox(height: 12),
                    for (final entry in sections.entries) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(entry.key, style: Theme.of(context).textTheme.titleMedium),
                      ),
                      ...entry.value.map((it) => _ItemCard(item: it, name: nameFor(it.exerciseId))),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.name});
  final WorkoutItem item;
  final String name;

  @override
  Widget build(BuildContext context) {
    final subtitle = item.isInterval
        ? '${item.workSeconds}s trabalho / ${item.intervalRestSeconds ?? 0}s descanso × ${item.rounds} rounds'
        : '${item.sets} séries × ${item.reps} reps • descanso ${item.restSeconds}s';

    return Card(
      child: ListTile(
        title: Text('${item.order}. $name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            if (item.professorComment != null && item.professorComment!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(children: [
                  const Icon(Icons.comment, size: 14),
                  const SizedBox(width: 4),
                  Expanded(child: Text(item.professorComment!, style: const TextStyle(fontStyle: FontStyle.italic))),
                ]),
              ),
          ],
        ),
        trailing: const Icon(Icons.info_outline),
        onTap: () => context.go('/exercises/${item.exerciseId}'),
      ),
    );
  }
}
