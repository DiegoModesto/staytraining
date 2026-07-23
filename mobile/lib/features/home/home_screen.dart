import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../core/util/dates.dart';
import '../../models/models.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<WeekScheduleItem>> _week;

  @override
  void initState() {
    super.initState();
    _week = ref.read(trainingApiProvider).getWeek(startOfWeek(DateTime.now()));
    // Kick off a background sync (push offline sessions + pull latest).
    Future.microtask(() => ref.read(syncServiceProvider).syncNow().catchError((_) {}));
  }

  void _reload() => setState(() {
        _week = ref.read(trainingApiProvider).getWeek(startOfWeek(DateTime.now()));
      });

  Future<void> _scheduleWorkout() async {
    final api = ref.read(trainingApiProvider);
    List<WorkoutListItem> workouts;
    try {
      workouts = await api.listWorkouts();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao carregar treinos: $e')));
      return;
    }
    if (!mounted) return;
    if (workouts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Você ainda não tem treinos para agendar.')));
      return;
    }

    final workout = await showModalBottomSheet<WorkoutListItem>(
      context: context,
      showDragHandle: true,
      builder: (c) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: workouts
              .map((w) => ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(w.name),
                    subtitle: Text('${w.itemCount} exercícios'),
                    onTap: () => Navigator.pop(c, w),
                  ))
              .toList(),
        ),
      ),
    );
    if (workout == null || !mounted) return;

    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 7)),
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'Agendar "${workout.name}"',
    );
    if (date == null) return;

    try {
      await api.scheduleWorkout(workout.id, date);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Treino agendado.')));
      _reload();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao agendar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scheduleWorkout,
        icon: const Icon(Icons.event_available),
        label: const Text('Agendar'),
      ),
      appBar: AppBar(
        title: const Text('StayTraining'),
        actions: [
          IconButton(
            tooltip: 'Sincronizar',
            icon: const Icon(Icons.sync),
            onPressed: () async {
              await ref.read(syncServiceProvider).syncNow().catchError((_) {});
              _reload();
            },
          ),
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider).logout(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _reload(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AdaptiveContainer(child: _WeekList(future: _week)),
          ],
        ),
      ),
    );
  }
}

class _WeekList extends StatelessWidget {
  const _WeekList({required this.future});
  final Future<List<WeekScheduleItem>> future;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sua semana', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        FutureBuilder<List<WeekScheduleItem>>(
          future: future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
            }
            if (snap.hasError) {
              return Card(child: ListTile(title: const Text('Falha ao carregar a agenda'), subtitle: Text('${snap.error}')));
            }
            final items = snap.data ?? [];
            if (items.isEmpty) {
              return const Card(child: ListTile(title: Text('Nenhum treino agendado para esta semana.')));
            }
            return Column(
              children: items
                  .map((i) => Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text(weekdayLabel(i.date))),
                          title: Text(i.workoutName),
                          trailing: FilledButton(
                            onPressed: () => context.go('/session/${i.workoutId}'),
                            child: const Text('Treinar'),
                          ),
                          onTap: () => context.go('/workouts/${i.workoutId}'),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

