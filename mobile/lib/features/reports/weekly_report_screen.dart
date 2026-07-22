import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/util/dates.dart';
import '../../models/models.dart';

class WeeklyReportScreen extends ConsumerStatefulWidget {
  const WeeklyReportScreen({super.key});

  @override
  ConsumerState<WeeklyReportScreen> createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends ConsumerState<WeeklyReportScreen> {
  late Future<WeeklyReport> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(trainingApiProvider).getWeeklyReport(startOfWeek(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatório semanal')),
      body: FutureBuilder<WeeklyReport>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Falha: ${snap.error}'));
          }
          final r = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _stat(context, 'Sessões', '${r.sessionCount}'),
                  _stat(context, 'Concluídas', '${r.completedSessionCount}'),
                  _stat(context, 'Treinos', '${r.distinctWorkoutCount}'),
                  _stat(context, 'Nota média', r.averageRating == null ? '-' : r.averageRating!.toStringAsFixed(1)),
                ],
              ),
              const SizedBox(height: 24),
              Text('Por exercício', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (r.exercises.isEmpty)
                const Text('Nenhum exercício executado nesta semana.')
              else
                ...r.exercises.map((e) => Card(
                      child: ListTile(
                        title: Text('Exercício ${e.exerciseId.substring(0, 8)}…'),
                        subtitle: Text('${e.timesPerformed}x • ${e.totalSets} séries • ${e.totalReps} reps'),
                        trailing: e.maxLoadKg == null ? null : Text('${e.maxLoadKg}kg'),
                      ),
                    )),
            ],
          );
        },
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
