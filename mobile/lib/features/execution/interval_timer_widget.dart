import 'dart:async';

import 'package:flutter/material.dart';

/// Interval timer for aerobic exercises: alternates work/rest for a number of rounds
/// (e.g. 60s trabalho / 30s descanso × 5). Shows the current phase, remaining seconds and round.
class IntervalTimerWidget extends StatefulWidget {
  const IntervalTimerWidget({
    super.key,
    required this.workSeconds,
    required this.restSeconds,
    required this.rounds,
  });

  final int workSeconds;
  final int restSeconds;
  final int rounds;

  @override
  State<IntervalTimerWidget> createState() => _IntervalTimerWidgetState();
}

enum _Phase { idle, work, rest, done }

class _IntervalTimerWidgetState extends State<IntervalTimerWidget> {
  Timer? _timer;
  _Phase _phase = _Phase.idle;
  int _round = 1;
  int _remaining = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _round = 1;
    _phase = _Phase.work;
    _remaining = widget.workSeconds;
    _tickLoop();
    setState(() {});
  }

  void _tickLoop() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remaining > 1) {
          _remaining--;
          return;
        }
        // Phase boundary.
        if (_phase == _Phase.work) {
          _phase = _Phase.rest;
          _remaining = widget.restSeconds;
        } else if (_phase == _Phase.rest) {
          if (_round >= widget.rounds) {
            _phase = _Phase.done;
            _timer?.cancel();
          } else {
            _round++;
            _phase = _Phase.work;
            _remaining = widget.workSeconds;
          }
        }
      });
    });
  }

  void _stop() {
    _timer?.cancel();
    setState(() {
      _phase = _Phase.idle;
      _remaining = 0;
      _round = 1;
    });
  }

  Color _phaseColor(BuildContext context) => switch (_phase) {
        _Phase.work => Colors.green,
        _Phase.rest => Colors.orange,
        _Phase.done => Theme.of(context).colorScheme.primary,
        _Phase.idle => Theme.of(context).colorScheme.surfaceContainerHighest,
      };

  String _phaseLabel() => switch (_phase) {
        _Phase.work => 'TRABALHO',
        _Phase.rest => 'DESCANSO',
        _Phase.done => 'CONCLUÍDO',
        _Phase.idle => 'PRONTO',
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _phaseColor(context).withValues(alpha: 0.15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('${widget.workSeconds}s / ${widget.restSeconds}s × ${widget.rounds}',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(_phaseLabel(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: _phaseColor(context), fontWeight: FontWeight.bold)),
            Text(
              _phase == _Phase.idle ? '${widget.workSeconds}' : '$_remaining',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            if (_phase != _Phase.idle && _phase != _Phase.done)
              Text('Round $_round / ${widget.rounds}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: (_phase == _Phase.idle || _phase == _Phase.done) ? _start : null,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: (_phase == _Phase.idle) ? null : _stop,
                  icon: const Icon(Icons.stop),
                  label: const Text('Parar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
