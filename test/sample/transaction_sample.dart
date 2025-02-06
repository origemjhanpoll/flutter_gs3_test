import 'package:flutter_gs3_test/app/models/transaction.dart';

Transaction get transactionSample => Transaction(
      id: 101,
      merchant: "Apple",
      amount: "545,99",
      installments: 12,
      date: DateTime.parse("2025-02-03T22:35:00Z"),
      category: "entertainment",
    );
