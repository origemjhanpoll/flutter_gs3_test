import 'package:flutter_gs3_test/app/models/card.dart';
import 'transaction_sample.dart';

BankCard get bankCardSample => BankCard(
      id: 1001,
      number: "5621",
      bank: "Banco do Brasil",
      type: "Crédito",
      brand: "Visa",
      limitAvailable: "7.867,80",
      bestPurchaseDay: 20,
      transactions: [transactionSample],
    );
