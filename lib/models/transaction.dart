import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final String merchant;
  final String amount;
  final int installments;
  final DateTime date;
  final String category;

  const Transaction({
    required this.id,
    required this.merchant,
    required this.amount,
    required this.installments,
    required this.date,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      merchant: json['merchant'],
      amount: json['amount'],
      installments: json['installments'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "merchant": merchant,
      "amount": amount,
      "installments": installments,
      "date": date.toIso8601String(),
      "category": category,
    };
  }

  Transaction copyWith({
    int? id,
    String? merchant,
    String? amount,
    int? installments,
    DateTime? date,
    String? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      merchant: merchant ?? this.merchant,
      amount: amount ?? this.amount,
      installments: installments ?? this.installments,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        merchant,
        amount,
        installments,
        date,
        category,
      ];
}
