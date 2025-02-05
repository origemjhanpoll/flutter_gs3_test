import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFavoritesWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Function(String item) onTapItem;

  const MyFavoritesWidget({super.key, this.onTap, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final favorites = [
      FavoritoItem(
        text: 'Cartão Virtual',
        asset: 'assets/icons/virtual-card.svg',
      ),
      FavoritoItem(
        text: 'Cartão adicional',
        asset: 'assets/icons/additional-card.svg',
      ),
      FavoritoItem(
        text: 'Seguros',
        asset: 'assets/icons/insurance.svg',
      ),
      FavoritoItem(
        text: 'Pacote SMS',
        asset: 'assets/icons/sms-package.svg',
      ),
      FavoritoItem(
        text: 'Sala VIP',
        asset: 'assets/icons/vip-room.svg',
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('Meus favoritos'),
          contentPadding: EdgeInsets.zero
              .copyWith(left: PaddingSize.medium, right: PaddingSize.small),
          titleTextStyle: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          trailing: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(PaddingSize.small),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: PaddingSize.small,
                children: [
                  Text(
                    'Personalizar',
                    style: theme.textTheme.bodySmall,
                  ),
                  SvgPicture.asset(
                    'assets/icons/more.svg',
                    width: 18.0,
                    height: 18.0,
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.primary, BlendMode.srcIn),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(90.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final favorite = favorites[index];
                return InkWell(
                  onTap: () => onTapItem(favorite.text),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: PaddingSize.medium),
                    child: Column(
                      spacing: PaddingSize.small * 0.5,
                      children: [
                        DecoratedBox(
                            decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Padding(
                              padding: EdgeInsets.all(PaddingSize.medium),
                              child: SvgPicture.asset(
                                favorite.asset,
                                colorFilter: ColorFilter.mode(
                                    theme.colorScheme.primary, BlendMode.srcIn),
                              ),
                            )),
                        Text(
                          favorite.text,
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}

class FavoritoItem {
  final String asset;
  final String text;

  FavoritoItem({required this.text, required this.asset});
}
