import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/providers.dart';

/// Opens a dialog for the student to ask the professor a question about a workout or exercise.
/// Exactly one of [workoutId]/[exerciseId] should be set; [targetLabel] names it in the UI.
Future<void> showAskQuestionDialog(
  BuildContext context,
  WidgetRef ref, {
  String? workoutId,
  String? exerciseId,
  required String targetLabel,
}) async {
  final controller = TextEditingController();
  final text = await showDialog<String>(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('Perguntar ao professor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(targetLabel, style: Theme.of(c).textTheme.bodySmall),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            autofocus: true,
            minLines: 3,
            maxLines: 6,
            maxLength: 4000,
            decoration: const InputDecoration(
              hintText: 'Escreva sua dúvida...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () => Navigator.pop(c, controller.text.trim()),
          child: const Text('Enviar'),
        ),
      ],
    ),
  );

  if (text == null || text.isEmpty || !context.mounted) return;

  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(trainingApiProvider).askQuestion(
          workoutId: workoutId,
          exerciseId: exerciseId,
          text: text,
        );
    ref.invalidate(myQuestionsProvider);
    if (!context.mounted) return;
    messenger.showSnackBar(SnackBar(
      content: const Text('Pergunta enviada ao professor.'),
      action: SnackBarAction(label: 'Ver', onPressed: () => context.go('/questions')),
    ));
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text('Falha ao enviar: $e')));
  }
}
