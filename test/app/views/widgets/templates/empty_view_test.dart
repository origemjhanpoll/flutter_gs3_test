import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/templates/empty_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  group('EmptyView =>', () {
    testWidgets('should display default empty message when no text is provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EmptyView(),
        ),
      );

      expect(find.text('Página vazia'), findsOneWidget);
    });

    testWidgets('should display provided text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EmptyView(text: 'Nenhum dado encontrado'),
        ),
      );

      expect(find.text('Nenhum dado encontrado'), findsOneWidget);
    });

    testWidgets('should display app bar when title is provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EmptyView(title: 'Minha Página'),
        ),
      );

      expect(find.text('Minha Página'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display SVG asset when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EmptyView(asset: 'assets/icon.svg'),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
