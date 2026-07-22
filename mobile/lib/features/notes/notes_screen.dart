import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/di/providers.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  late Future<List<Map<String, dynamic>>> _future;
  static final _fmt = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _future = ref.read(trainingApiProvider).getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anotações')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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

          // Group by session date.
          final groups = <String, List<Map<String, dynamic>>>{};
          for (final n in notes) {
            final date = DateTime.tryParse(n['sessionDate'] as String? ?? '') ?? DateTime.now();
            groups.putIfAbsent(_fmt.format(date), () => []).add(n);
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: groups.entries.map((g) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(g.key, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ...g.value.map((n) {
                    final load = n['loadKg'];
                    final pain = n['painFlag'] == true;
                    final comment = n['comment'] as String?;
                    return Card(
                      child: ListTile(
                        leading: Icon(pain ? Icons.warning_amber : Icons.check_circle_outline,
                            color: pain ? Colors.orange : Colors.green),
                        title: Text([
                          if (load != null) 'Carga: ${load}kg',
                          if (n['performedSets'] != null) '${n['performedSets']}x${n['performedReps'] ?? '?'}',
                        ].join(' • ')),
                        subtitle: comment == null ? null : Text(comment),
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
