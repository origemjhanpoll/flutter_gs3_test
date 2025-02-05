import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBoxWidget extends StatelessWidget {
  final String asset;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  const IconBoxWidget({
    super.key,
    required this.asset,
    this.borderRadius = 12.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Padding(
          padding: padding ?? EdgeInsets.all(PaddingSize.medium),
          child: SvgPicture.asset(
            asset,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ));
  }
}
