import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  late Future<List<SessionNote>> _future;
  static final _fmt = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _future = ref.read(trainingApiProvider).getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(exerciseCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Anotações')),
      body: FutureBuilder<List<SessionNote>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Falha: ${snap.error}'));
          }
          final notes = snap.data ?? [];
          if (notes.isEmpty) {
            return const Center(child: Text('Nenhuma anotação ainda.'));
          }

          // Group by session date (newest groups first, as the API returns newest-first).
          final groups = <String, List<SessionNote>>{};
          for (final n in notes) {
            groups.putIfAbsent(_fmt.format(n.sessionDate), () => []).add(n);
          }

          String nameFor(String id) => catalog.maybeWhen(
                data: (c) => c.nameFor(id),
                orElse: () => 'Exercício',
              );

          return ListView(
            children: [
              AdaptiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: groups.entries.map((g) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(g.key, style: Theme.of(context).textTheme.titleMedium),
                        ),
                        ...g.value.map((n) {
                          final metrics = [
                            if (n.loadKg != null) 'Carga: ${n.loadKg!.toStringAsFixed(n.loadKg! % 1 == 0 ? 0 : 1)} kg',
                            if (n.performedSets != null) '${n.performedSets}×${n.performedReps ?? '?'}',
                          ].join(' • ');
                          return Card(
                            child: ListTile(
                              leading: Icon(n.painFlag ? Icons.warning_amber : Icons.check_circle_outline,
                                  color: n.painFlag ? Colors.orange : Colors.green),
                              title: Text(nameFor(n.exerciseId)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (metrics.isNotEmpty) Text(metrics),
                                  if (n.comment != null && n.comment!.isNotEmpty) Text(n.comment!),
                                  if (n.painFlag && (n.painNote?.isNotEmpty ?? false))
                                    Text('Dor: ${n.painNote}', style: const TextStyle(color: Colors.orange)),
                                ],
                              ),
                              isThreeLine: n.comment != null,
                            ),
                          );
                        }),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
