import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/card_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardWidget =>', () {
    testWidgets('should render correctly with required properties',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: CardWidget(
              id: 1,
              number: '1234',
              bank: 'Bank Test',
              type: 'Credit',
              brand: 'Visa',
              limitAvailable: '5000',
              bestPurchaseDay: 15,
              size: const Size(300, 180),
              color: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector).at(1), findsOneWidget);
      expect(find.byType(SizedBox).at(1), findsOneWidget);
      expect(find.byType(DecoratedBox).at(1), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(3));
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.textContaining('●●●● 1234'), findsOneWidget);
      expect(find.text('Bank Test'), findsOneWidget);
      expect(find.text('Limite disponível'), findsOneWidget);
      expect(find.text('R\$ 5000'), findsOneWidget);
      expect(find.text('Melhor dia de compra'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('should toggle limit visibility when visibility icon is tapped',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: CardWidget(
              id: 1,
              number: '1234',
              bank: 'Bank Test',
              type: 'Credit',
              brand: 'Visa',
              limitAvailable: '5000',
              bestPurchaseDay: 15,
              size: const Size(300, 180),
              color: Colors.blue,
            ),
          ),
        ),
      );

      final visibilityIconFinder = find.byIcon(Icons.visibility);
      final hiddenIconFinder = find.byIcon(Icons.visibility_off);
      expect(visibilityIconFinder, findsOneWidget);
      expect(hiddenIconFinder, findsNothing);
      expect(find.text('R\$ 5000'), findsOneWidget);

      await tester.tap(visibilityIconFinder);
      await tester.pump();

      expect(find.text('●●●●'), findsOneWidget);
      expect(hiddenIconFinder, findsOneWidget);
      expect(visibilityIconFinder, findsNothing);

      await tester.tap(hiddenIconFinder);
      await tester.pump();

      expect(find.text('R\$ 5000'), findsOneWidget);
      expect(visibilityIconFinder, findsOneWidget);
      expect(hiddenIconFinder, findsNothing);
    });

    testWidgets('should trigger onTap when tapped', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardWidget(
              id: 1,
              number: '1234',
              bank: 'Bank Test',
              type: 'Credit',
              brand: 'Visa',
              limitAvailable: '5000',
              bestPurchaseDay: 15,
              size: const Size(300, 180),
              color: Colors.blue,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(wasTapped, isTrue);
    });
  });
}
