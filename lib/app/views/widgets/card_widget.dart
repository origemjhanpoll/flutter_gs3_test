import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final int id;
  final String number;
  final String type;
  final String brand;
  final String limitAvailable;
  final int? bestPurchaseDay;
  final Size size;
  final VoidCallback? onTap;

  const CardWidget({
    super.key,
    required this.id,
    required this.number,
    required this.type,
    required this.brand,
    required this.limitAvailable,
    this.bestPurchaseDay,
    required this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.fromSize(
        size: size,
        child: Card(
          color: Colors.red,
          elevation: 0.0,
          margin: EdgeInsets.zero,
          child: ListTile(
            title: Text('Cartão $number'),
            subtitle: Text('$brand - $type'),
          ),
        ),
      ),
    );
  }
}
