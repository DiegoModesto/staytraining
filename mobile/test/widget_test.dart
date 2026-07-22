import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staytraining/features/execution/interval_timer_widget.dart';

void main() {
  testWidgets('IntervalTimerWidget shows idle state and config', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IntervalTimerWidget(workSeconds: 60, restSeconds: 30, rounds: 5),
      ),
    ));

    expect(find.text('PRONTO'), findsOneWidget);
    expect(find.text('60s / 30s × 5'), findsOneWidget);
    expect(find.text('Iniciar'), findsOneWidget);
  });
}
