import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/models/transaction.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_gs3_test/core/utils/format_date.dart';

import 'transaction_widget.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionListWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.separated(
      itemCount: transactions.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final showDate = index == 0 ||
            formatDate(transactions[index - 1].date) !=
                formatDate(transaction.date);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDate)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: PaddingSize.medium),
                child: Text(
                  formatDate(transaction.date),
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            TransactionWidget(
              id: transaction.id,
              merchant: transaction.merchant,
              amount: transaction.amount,
              installments: transaction.installments,
              date: transaction.date,
              category: transaction.category,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) =>
          Divider(indent: 16.0, endIndent: 16.0),
    );
  }
}
