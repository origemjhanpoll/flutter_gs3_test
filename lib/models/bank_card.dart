import 'package:equatable/equatable.dart';
import 'Transaction.dart'; // Importando a classe Transaction

class BankCard extends Equatable {
  final int id;
  final String number;
  final String type;
  final String brand;
  final String limitAvailable;
  final int? bestPurchaseDay;
  final List<Transaction> transactions;

  const BankCard({
    required this.id,
    required this.number,
    required this.type,
    required this.brand,
    required this.limitAvailable,
    this.bestPurchaseDay,
    required this.transactions,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      id: json['id'],
      number: json['number'],
      type: json['type'],
      brand: json['brand'],
      limitAvailable: json['limit_available'],
      bestPurchaseDay: json['best_purchase_day'],
      transactions: (json['transactions'] as List)
          .map((item) => Transaction.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "number": number,
      "type": type,
      "brand": brand,
      "limit_available": limitAvailable,
      "best_purchase_day": bestPurchaseDay,
      "transactions": transactions.map((t) => t.toJson()).toList(),
    };
  }

  BankCard copyWith({
    int? id,
    String? number,
    String? type,
    String? brand,
    String? limitAvailable,
    int? bestPurchaseDay,
    List<Transaction>? transactions,
  }) {
    return BankCard(
      id: id ?? this.id,
      number: number ?? this.number,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      limitAvailable: limitAvailable ?? this.limitAvailable,
      bestPurchaseDay: bestPurchaseDay ?? this.bestPurchaseDay,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        number,
        type,
        brand,
        limitAvailable,
        bestPurchaseDay,
        transactions,
      ];
}
