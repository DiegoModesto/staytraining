import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final content = _WeekAndNav(weekFuture: _week, wide: wide, onRefresh: _reload);
          return content;
        },
      ),
    );
  }
}

class _WeekAndNav extends StatelessWidget {
  const _WeekAndNav({required this.weekFuture, required this.wide, required this.onRefresh});
  final Future<List<WeekScheduleItem>> weekFuture;
  final bool wide;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final nav = _NavCards(wide: wide);
    final week = _WeekList(future: weekFuture);

    if (wide) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: week),
            const SizedBox(width: 16),
            SizedBox(width: 320, child: nav),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [week, const SizedBox(height: 16), nav],
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

class _NavCards extends StatelessWidget {
  const _NavCards({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _tile(context, Icons.fitness_center, 'Meus treinos', '/workouts'),
      _tile(context, Icons.notes, 'Anotações', '/notes'),
      _tile(context, Icons.insights, 'Relatório semanal', '/reports'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: tiles);
  }

  Widget _tile(BuildContext context, IconData icon, String label, String route) => Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.go(route),
        ),
      );
}
