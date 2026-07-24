import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../models/models.dart';

/// Predefined skip reasons (code → label).
const scheduleSkipReasons = <String, String>{
  'feriado': 'Feriado',
  'academia_fechada': 'Academia fechada',
  'doenca': 'Doença',
  'viagem': 'Viagem',
  'lesao': 'Lesão',
  'outro': 'Outro',
};

/// Dialog to justify NOT doing a scheduled workout. Returns true when saved.
Future<bool> showJustifyDialog(BuildContext context, WidgetRef ref, WeekScheduleItem item) async {
  String reason = scheduleSkipReasons.keys.first;
  final noteCtrl = TextEditingController();

  final ok = await showDialog<bool>(
    context: context,
    builder: (c) => StatefulBuilder(
      builder: (c, setState) => AlertDialog(
        title: const Text('Justificar treino'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.workoutName, style: Theme.of(c).textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: reason,
              decoration: const InputDecoration(labelText: 'Motivo', border: OutlineInputBorder()),
              items: [
                for (final e in scheduleSkipReasons.entries)
                  DropdownMenuItem(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) => setState(() => reason = v ?? reason),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteCtrl,
              minLines: 2,
              maxLines: 4,
              maxLength: 1000,
              decoration: const InputDecoration(
                labelText: 'Observação (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Justificar')),
        ],
      ),
    ),
  );

  if (ok != true || !context.mounted) return false;
  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(trainingApiProvider).justifySkip(item.scheduleId, reason, noteCtrl.text.trim());
    messenger.showSnackBar(const SnackBar(content: Text('Treino justificado.')));
    return true;
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text('Falha: $e')));
    return false;
  }
}

/// Dialog to move a scheduled workout to another day. Returns true when swapped.
Future<bool> showSwapDialog(BuildContext context, WidgetRef ref, WeekScheduleItem item) async {
  final now = DateTime.now();
  final picked = await showDatePicker(
    context: context,
    initialDate: item.date.isAfter(now) ? item.date : now,
    firstDate: now.subtract(const Duration(days: 7)),
    lastDate: now.add(const Duration(days: 60)),
    helpText: 'Trocar "${item.workoutName}" para',
  );
  if (picked == null || !context.mounted) return false;

  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(trainingApiProvider).swapDay(item.scheduleId, picked);
    messenger.showSnackBar(const SnackBar(content: Text('Treino remarcado.')));
    return true;
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text('Falha: $e')));
    return false;
  }
}
