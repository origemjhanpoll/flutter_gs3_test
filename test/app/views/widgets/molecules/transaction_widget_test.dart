import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/transaction_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/atoms/icon_box_widget.dart';
import 'package:flutter_gs3_test/core/utils/format_date.dart';

void main() {
  group('TransactionWidget =>', () {
    testWidgets('should display merchant name and amount', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionWidget(
              id: 1,
              merchant: 'Supermercado X',
              amount: '120,50',
              installments: 1,
              date: DateTime(2024, 2, 5, 15, 30),
              category: 'essential',
            ),
          ),
        ),
      );

      expect(find.text('Supermercado X'), findsOneWidget);
      expect(find.text('R\$ 120,50'), findsOneWidget);
    });

    testWidgets('should display formatted date', (tester) async {
      final testDate = DateTime(2024, 2, 5, 15, 30);
      final formattedDate = formatDateWithHours(testDate);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionWidget(
              id: 1,
              merchant: 'Loja Y',
              amount: '75,00',
              installments: 1,
              date: testDate,
              category: 'entertainment',
            ),
          ),
        ),
      );

      expect(find.text(formattedDate), findsOneWidget);
    });

    testWidgets('should display installments text when greater than 1',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionWidget(
              id: 2,
              merchant: 'Eletrônicos Z',
              amount: '2500,00',
              installments: 5,
              date: DateTime(2024, 2, 5, 12, 0),
              category: 'transport',
            ),
          ),
        ),
      );

      expect(find.text('em 5x'), findsOneWidget);
    });

    testWidgets('should display correct category icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionWidget(
              id: 3,
              merchant: 'Cinema',
              amount: '30,00',
              installments: 1,
              date: DateTime(2024, 2, 5, 18, 45),
              category: 'entertainment',
            ),
          ),
        ),
      );

      expect(find.byType(IconBoxWidget), findsOneWidget);
    });
  });
}
