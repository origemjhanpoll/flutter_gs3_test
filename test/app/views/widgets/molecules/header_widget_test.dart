import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/header_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeaderWidget =>', () {
    testWidgets('should display title correctly', (tester) async {
      const title = 'Meu Título';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderWidget(title: title),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('should display actionText when provided', (tester) async {
      const title = 'Meu Título';
      const actionText = 'Ver mais';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderWidget(title: title, actionText: actionText),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(actionText), findsOneWidget);
    });

    testWidgets('should trigger onTap when actionText is tapped',
        (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderWidget(
              title: 'Meu Título',
              actionText: 'Ver mais',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Ver mais'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('should display action widget when provided', (tester) async {
      const title = 'Meu Título';
      const actionText = 'Ver mais';
      const actionIcon = Icon(Icons.arrow_forward);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderWidget(
              title: title,
              actionText: actionText,
              action: actionIcon,
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(actionText), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}
