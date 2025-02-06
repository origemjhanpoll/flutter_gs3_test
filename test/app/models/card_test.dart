import 'package:flutter_gs3_test/app/models/card.dart';
import 'package:flutter_gs3_test/app/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../load_json.dart';
import '../../sample/card_sample.dart';
import '../../sample/transaction_sample.dart';

void main() async {
  final bankCardJson = await loadJson('test/json/card.json');

  group('BankCard Model =>', () {
    test('should create a BankCard instance correctly', () {
      expect(bankCardSample.id, 1001);
      expect(bankCardSample.number, "5621");
      expect(bankCardSample.bank, "Banco do Brasil");
      expect(bankCardSample.type, "Crédito");
      expect(bankCardSample.brand, "Visa");
      expect(bankCardSample.limitAvailable, "7.867,80");
      expect(bankCardSample.bestPurchaseDay, 20);
      expect(bankCardSample.transactions, isA<List<Transaction>>());
      expect(bankCardSample.transactions.length, 1);
    });

    test('should convert a JSON into a BankCard object correctly', () {
      final bankCardFromJson = BankCard.fromJson(bankCardJson);

      expect(bankCardFromJson, equals(bankCardSample));
    });

    test('should convert a BankCard object into JSON correctly', () {
      final json = bankCardSample.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], bankCardSample.id);
      expect(json['number'], bankCardSample.number);
      expect(json['bank'], bankCardSample.bank);
      expect(json['type'], bankCardSample.type);
      expect(json['brand'], bankCardSample.brand);
      expect(json['limit_available'], bankCardSample.limitAvailable);
      expect(json['best_purchase_day'], bankCardSample.bestPurchaseDay);
      expect(json['transactions'], isA<List>());
    });

    test('copyWith should create a new modified instance correctly', () {
      final modifiedBankCard = bankCardSample.copyWith(bank: "Banco ABC");

      expect(modifiedBankCard.bank, "Banco ABC");
      expect(modifiedBankCard.id, bankCardSample.id);
      expect(modifiedBankCard.number, bankCardSample.number);
    });

    test('equatable should ensure object equality with the same values', () {
      final anotherBankCard = BankCard(
        id: 1001,
        number: "5621",
        bank: "Banco do Brasil",
        type: "Crédito",
        brand: "Visa",
        limitAvailable: "7.867,80",
        bestPurchaseDay: 20,
        transactions: [transactionSample],
      );

      expect(bankCardSample, equals(anotherBankCard));
    });
  });
}
