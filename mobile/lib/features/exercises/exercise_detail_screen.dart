import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/di/providers.dart';
import '../../core/ui/responsive.dart';
import '../../models/models.dart';
import '../questions/ask_question.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});
  final String exerciseId;

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  late Future<Exercise> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(trainingApiProvider).getExercise(widget.exerciseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercício')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAskQuestionDialog(
          context,
          ref,
          exerciseId: widget.exerciseId,
          targetLabel: 'Sobre este exercício',
        ),
        icon: const Icon(Icons.help_outline),
        label: const Text('Perguntar'),
      ),
      body: FutureBuilder<Exercise>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Falha: ${snap.error}'));
          }
          final e = snap.data!;
          return ListView(
            children: [
              AdaptiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              Text(e.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Chip(label: Text(e.modalityName)),
              const SizedBox(height: 16),
              _MediaSection(exercise: e),
              if (e.description != null) ...[
                const SizedBox(height: 16),
                Text('Descrição', style: Theme.of(context).textTheme.titleMedium),
                Text(e.description!),
              ],
              if (e.usageExample != null) ...[
                const SizedBox(height: 16),
                Text('Como executar', style: Theme.of(context).textTheme.titleMedium),
                Text(e.usageExample!),
              ],
              const SizedBox(height: 16),
              Text('Prescrição padrão', style: Theme.of(context).textTheme.titleMedium),
              Text(e.isAerobic
                  ? '${e.defaultWorkSeconds ?? 0}s / ${e.defaultIntervalRestSeconds ?? 0}s × ${e.defaultRounds ?? 0}'
                  : '${e.defaultSets} × ${e.defaultReps} • descanso ${e.defaultRestSeconds}s'),
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

class _MediaSection extends StatelessWidget {
  const _MediaSection({required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final youtube = exercise.media.where((m) => m.kind == ExerciseMediaKind.youtubeUrl && m.url != null).toList();
    if (youtube.isNotEmpty) {
      final id = YoutubePlayer.convertUrlToId(youtube.first.url!);
      if (id != null) {
        return YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: id,
            flags: const YoutubePlayerFlags(autoPlay: false),
          ),
          showVideoProgressIndicator: true,
        );
      }
    }

    // Otherwise, show the first image/gif whose url is set (presigned URL from the API).
    final image = exercise.media.where((m) => m.url != null).toList();
    if (image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(imageUrl: image.first.url!, fit: BoxFit.cover),
      );
    }

    return const Card(child: ListTile(leading: Icon(Icons.image_not_supported), title: Text('Sem mídia')));
  }
}
