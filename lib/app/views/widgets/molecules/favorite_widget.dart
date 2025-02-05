import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String asset;

  const FavoriteWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: PaddingSize.medium)
            .copyWith(top: PaddingSize.small),
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
                    asset,
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.primary, BlendMode.srcIn),
                  ),
                )),
            Text(
              text,
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

class FavoritoItem {
  final String asset;
  final String text;

  FavoritoItem({required this.text, required this.asset});
}
