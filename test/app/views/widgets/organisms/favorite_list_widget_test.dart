import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/favorite_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/favorite_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteListWidget =>', () {
    testWidgets('should render all favorite items', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FavoriteListWidget(),
          ),
        ),
      );

      expect(find.byType(FavoriteWidget), findsNWidgets(5));
      expect(find.text('Cartão Virtual'), findsOneWidget);
      expect(find.text('Cartão adicional'), findsOneWidget);
      expect(find.text('Seguros'), findsOneWidget);
      expect(find.text('Pacote SMS'), findsOneWidget);
      expect(find.text('Sala VIP'), findsOneWidget);
    });

    testWidgets('should trigger onTap when an item is tapped', (tester) async {
      FavoriteType? tappedFavorite;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteListWidget(
              onTap: (favorite) {
                tappedFavorite = favorite;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Cartão Virtual'));
      await tester.pump();

      expect(tappedFavorite, isNotNull);
      expect(tappedFavorite!.text, equals('Cartão Virtual'));
      expect(tappedFavorite!.asset, equals('assets/icons/virtual-card.svg'));
    });
  });
}
