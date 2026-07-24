import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../core/util/dates.dart';
import '../../models/models.dart';
import '../schedule/schedule_actions.dart';

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
    // No scheduling in the app — the professor schedules a student's week in the backoffice.
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
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myProfileProvider);
          _reload();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AdaptiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Greeting(name: ref.watch(myProfileProvider).asData?.value.fullName),
                  const SizedBox(height: 16),
                  _WeekList(future: _week, onChanged: _reload),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Personalized greeting. Shows the student's first name once the profile loads; a neutral
/// greeting meanwhile (and offline, until the cached profile arrives).
class _Greeting extends StatelessWidget {
  const _Greeting({required this.name});
  final String? name;

  @override
  Widget build(BuildContext context) {
    final firstName = (name ?? '').trim().split(RegExp(r'\s+')).first;
    final greeting = firstName.isEmpty ? 'Olá 👋' : 'Olá, $firstName 👋';
    return Text(greeting, style: Theme.of(context).textTheme.headlineSmall);
  }
}

class _WeekList extends ConsumerWidget {
  const _WeekList({required this.future, required this.onChanged});
  final Future<List<WeekScheduleItem>> future;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            return Column(children: [for (final i in items) _scheduleCard(context, ref, i)]);
          },
        ),
      ],
    );
  }

  Widget _scheduleCard(BuildContext context, WidgetRef ref, WeekScheduleItem i) {
    final theme = Theme.of(context);
    String? subtitle;
    Widget? trailing;

    if (i.completed) {
      subtitle = 'Concluído';
      trailing = Icon(Icons.check_circle, color: theme.colorScheme.primary);
    } else if (i.isSkipped) {
      final reason = scheduleSkipReasons[i.justificationReason] ?? i.justificationReason;
      subtitle = reason == null ? 'Justificado' : 'Justificado • $reason';
      trailing = Icon(Icons.event_busy, color: theme.colorScheme.onSurfaceVariant);
    } else if (i.isSwapped) {
      subtitle = i.swappedToDate == null
          ? 'Trocado'
          : 'Trocado p/ ${i.swappedToDate!.day.toString().padLeft(2, '0')}/${i.swappedToDate!.month.toString().padLeft(2, '0')}';
      trailing = Icon(Icons.swap_horiz, color: theme.colorScheme.onSurfaceVariant);
    } else {
      // Pending: treinar + ações (justificar / trocar de dia).
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: () => context.go('/session/${i.workoutId}'),
            child: const Text('Treinar'),
          ),
          PopupMenuButton<String>(
            tooltip: 'Ações',
            onSelected: (v) async {
              final ok = v == 'justify'
                  ? await showJustifyDialog(context, ref, i)
                  : await showSwapDialog(context, ref, i);
              if (ok) onChanged();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'justify', child: Text('Justificar')),
              PopupMenuItem(value: 'swap', child: Text('Trocar de dia')),
            ],
          ),
        ],
      );
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(weekdayLabel(i.date))),
        title: Text(i.workoutName),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: trailing,
        onTap: () => context.go('/workouts/${i.workoutId}'),
      ),
    );
  }
}

