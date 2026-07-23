import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staytraining/core/ui/responsive.dart';

Widget _harness(Size size, Widget child) => MediaQuery(
      data: MediaQueryData(size: size),
      child: MaterialApp(home: Scaffold(body: child)),
    );

void main() {
  group('AdaptiveCardGrid', () {
    final cards = List.generate(4, (i) => Card(child: Text('c$i')));

    testWidgets('single column (Column, no GridView) on phone width', (tester) async {
      await tester.pumpWidget(_harness(const Size(390, 800), AdaptiveCardGrid(children: cards)));
      expect(find.byType(GridView), findsNothing);
      expect(find.text('c0'), findsOneWidget);
      expect(find.text('c3'), findsOneWidget);
    });

    testWidgets('uses a GridView on tablet width', (tester) async {
      await tester.pumpWidget(_harness(const Size(900, 1200), AdaptiveCardGrid(children: cards)));
      expect(find.byType(GridView), findsOneWidget);
    });
  });

  testWidgets('AdaptiveContainer caps content width on large screens', (tester) async {
    await tester.pumpWidget(_harness(const Size(1400, 900), const AdaptiveContainer(child: Text('conteúdo'))));
    final box = tester.widget<ConstrainedBox>(
      find.descendant(of: find.byType(AdaptiveContainer), matching: find.byType(ConstrainedBox)).first,
    );
    expect(box.constraints.maxWidth, Breakpoints.contentMaxWidth);
    expect(find.text('conteúdo'), findsOneWidget);
  });

  test('ScreenSize breakpoints', () {
    // Sanity on the thresholds used across the app.
    expect(Breakpoints.tablet, 720);
    expect(Breakpoints.large, 1080);
  });
}
