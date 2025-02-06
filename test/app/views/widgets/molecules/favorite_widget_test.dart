import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/atoms/icon_box_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/favorite_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteWidget =>', () {
    testWidgets('should display text and icon correctly', (tester) async {
      const text = 'Cartão Virtual';
      const asset = 'assets/icons/virtual-card.svg';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FavoriteWidget(
              text: text,
              asset: asset,
            ),
          ),
        ),
      );

      expect(find.text(text), findsOneWidget);
      expect(find.byType(IconBoxWidget), findsOneWidget);
    });

    testWidgets('should trigger onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget(
              text: 'Cartão Virtual',
              asset: 'assets/icons/virtual-card.svg',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
