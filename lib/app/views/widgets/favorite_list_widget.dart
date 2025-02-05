import 'package:flutter/material.dart';

import 'favorite_widget.dart';

class FavoriteListWidget extends StatelessWidget {
  final ValueChanged<FavoriteType>? onTap;

  const FavoriteListWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final favorites = [
      FavoriteType(
        text: 'Cartão Virtual',
        asset: 'assets/icons/virtual-card.svg',
      ),
      FavoriteType(
        text: 'Cartão adicional',
        asset: 'assets/icons/additional-card.svg',
      ),
      FavoriteType(
        text: 'Seguros',
        asset: 'assets/icons/insurance.svg',
      ),
      FavoriteType(
        text: 'Pacote SMS',
        asset: 'assets/icons/sms-package.svg',
      ),
      FavoriteType(
        text: 'Sala VIP',
        asset: 'assets/icons/vip-room.svg',
      ),
    ];

    return SizedBox.fromSize(
      size: Size.fromHeight(100.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: favorites.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final favorite = favorites[index];
            return FavoriteWidget(
              onTap: onTap != null ? () => onTap!(favorite) : null,
              text: favorite.text,
              asset: favorite.asset,
            );
          }),
    );
  }
}

class FavoriteType {
  final String asset;
  final String text;

  FavoriteType({required this.text, required this.asset});
}
