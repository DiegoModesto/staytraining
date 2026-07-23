import 'package:flutter/widgets.dart';

/// Breakpoints centrais do app (largura lógica em dp).
class Breakpoints {
  static const double tablet = 720;
  static const double large = 1080;

  /// Largura máxima de conteúdo legível — evita listas/forms esticados em tablet/desktop.
  static const double contentMaxWidth = 760;
}

enum ScreenSize { phone, tablet, large }

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenSize get screenSize {
    final w = screenWidth;
    if (w >= Breakpoints.large) return ScreenSize.large;
    if (w >= Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.phone;
  }

  bool get isTablet => screenSize != ScreenSize.phone;

  /// Nº de colunas para grades de cards conforme o tamanho de tela.
  int get gridColumns => switch (screenSize) {
        ScreenSize.large => 3,
        ScreenSize.tablet => 2,
        ScreenSize.phone => 1,
      };
}

/// Centraliza e limita a largura do conteúdo em telas largas (tablet/desktop),
/// mantendo o full-bleed no celular. Use como raiz do corpo das telas roláveis.
class AdaptiveContainer extends StatelessWidget {
  const AdaptiveContainer({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.contentMaxWidth,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(padding: padding, child: child),
        ),
      );
}

/// Grade responsiva de cards: 1 coluna no celular, 2 no tablet, 3 em telas grandes.
/// Não rola por si só — envolva num ListView/CustomScrollView ou use dentro de um Column.
class AdaptiveCardGrid extends StatelessWidget {
  const AdaptiveCardGrid({
    super.key,
    required this.children,
    this.spacing = 12,
    this.childAspectRatio = 3.2,
  });

  final List<Widget> children;
  final double spacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final columns = context.gridColumns;
    if (columns == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            children[i],
          ],
        ],
      );
    }
    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      childAspectRatio: childAspectRatio,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
