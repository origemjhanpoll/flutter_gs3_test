import 'package:flutter_gs3_test/app/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../load_json.dart';
import '../../sample/transaction_sample.dart';

void main() async {
  final transactionJson = await loadJson('test/json/transaction.json');

  group('Transaction Model =>', () {
    test('should create a Transaction instance correctly', () {
      expect(transactionSample.id, 101);
      expect(transactionSample.merchant, "Apple");
      expect(transactionSample.amount, "545,99");
      expect(transactionSample.installments, 12);
      expect(transactionSample.date, isA<DateTime>());
      expect(transactionSample.category, "entertainment");
    });

    test('should convert a JSON into a Transaction object correctly', () {
      final transactionFromJson = Transaction.fromJson(transactionJson);

      expect(transactionFromJson, equals(transactionSample));
    });

    test('should convert a Transaction object into JSON correctly', () {
      final json = transactionSample.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], transactionSample.id);
      expect(json['merchant'], transactionSample.merchant);
      expect(json['amount'], transactionSample.amount);
      expect(json['installments'], transactionSample.installments);
      expect(json['date'], transactionSample.date.toIso8601String());
      expect(json['category'], transactionSample.category);
    });

    test('copyWith should create a new modified instance correctly', () {
      final modifiedTransaction = transactionSample.copyWith(merchant: "Apple");

      expect(modifiedTransaction.merchant, "Apple");
      expect(modifiedTransaction.id, transactionSample.id);
      expect(modifiedTransaction.amount, transactionSample.amount);
    });

    test('equatable should ensure object equality with the same values', () {
      final anotherTransaction = Transaction(
        id: 101,
        merchant: "Apple",
        amount: "545,99",
        installments: 12,
        date: transactionSample.date,
        category: "entertainment",
      );

      expect(transactionSample, equals(anotherTransaction));
    });
  });
}
