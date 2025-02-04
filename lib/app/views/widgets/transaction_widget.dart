import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final int id;
  final String merchant;
  final String amount;
  final int installments;
  final DateTime date;
  final String category;

  const TransactionWidget({
    super.key,
    required this.id,
    required this.merchant,
    required this.amount,
    required this.installments,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(merchant),
      subtitle: Text('Valor: $amount'),
      trailing: Text('Data: ${date.toString()}'),
    );
  }
}
