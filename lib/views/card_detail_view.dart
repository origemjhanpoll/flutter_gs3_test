import 'package:flutter/material.dart';
import '../models/bank_card.dart';

class CardDetailView extends StatelessWidget {
  final BankCard card;

  const CardDetailView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartão ${card.number}'),
      ),
      body: ListView.builder(
        itemCount: card.transactions.length,
        itemBuilder: (context, index) {
          final transaction = card.transactions[index];
          return ListTile(
            title: Text(transaction.merchant),
            subtitle: Text('Valor: ${transaction.amount}'),
            trailing: Text('Data: ${transaction.date.toString()}'),
          );
        },
      ),
    );
  }
}
