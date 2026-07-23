import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';

/// The student's questions to the professor, with answers when available.
class QuestionsScreen extends ConsumerWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(myQuestionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas perguntas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myQuestionsProvider.future),
        child: questions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(child: Text('Falha ao carregar: $e')),
              ),
            ],
          ),
          data: (items) => items.isEmpty
              ? ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'Você ainda não fez perguntas.\nPergunte ao professor a partir de um treino ou exercício.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    AdaptiveContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [for (final q in items) _QuestionCard(question: q)],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(question.about, style: theme.textTheme.labelMedium),
                ),
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(question.isAnswered ? 'Respondida' : 'Aguardando'),
                  backgroundColor: question.isAnswered
                      ? theme.colorScheme.secondaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(question.text),
            if (question.isAnswered) ...[
              const Divider(height: 24),
              Row(
                children: [
                  Icon(Icons.verified, size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    question.answeredByName ?? 'Professor',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(question.answerText!),
            ],
          ],
        ),
      ),
    );
  }
}
