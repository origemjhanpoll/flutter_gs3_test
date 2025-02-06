import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/transaction_list_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/transaction_widget.dart';
import 'package:flutter_gs3_test/app/models/transaction.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('pt_BR', null);
  });

  group('TransactionListWidget => ', () {
    final transactions = [
      Transaction(
        id: 1,
        merchant: 'Loja A',
        amount: '50.00',
        installments: 1,
        date: DateTime(2024, 2, 1, 10, 30),
        category: 'essential',
      ),
      Transaction(
        id: 2,
        merchant: 'Loja B',
        amount: '20.00',
        installments: 2,
        date: DateTime(2024, 2, 1, 15, 00),
        category: 'transport',
      ),
      Transaction(
        id: 3,
        merchant: 'Loja C',
        amount: '100.00',
        installments: 1,
        date: DateTime(2024, 2, 2, 12, 45),
        category: 'entertainment',
      ),
    ];

    testWidgets('should display all transactions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionListWidget(transactions: transactions),
          ),
        ),
      );

      expect(find.text('Loja A'), findsOneWidget);
      expect(find.text('Loja B'), findsOneWidget);
      expect(find.text('Loja C'), findsOneWidget);
      expect(find.byType(TransactionWidget), findsNWidgets(3));
    });

    testWidgets('should display dates separating transactions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionListWidget(transactions: transactions),
          ),
        ),
      );

      expect(find.text('01/02 às 10:30'), findsOneWidget);
      expect(find.text('01/02 às 15:00'), findsOneWidget);
      expect(find.text('02/02 às 12:45'), findsOneWidget);
      expect(find.byType(TransactionWidget), findsNWidgets(3));
    });

    testWidgets('should display a separator between transactions',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionListWidget(transactions: transactions),
          ),
        ),
      );

      expect(find.byType(Divider), findsNWidgets(2));
    });
  });
}
