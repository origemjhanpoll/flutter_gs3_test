import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? actionText;
  final Widget? action;
  const HeaderWidget({
    super.key,
    this.onTap,
    required this.title,
    this.action,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: PaddingSize.medium,
        right: PaddingSize.small,
        bottom: PaddingSize.small,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          if (actionText != null)
            InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(PaddingSize.small),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: PaddingSize.small,
                  children: [
                    Text(
                      actionText!,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.primaryColor),
                    ),
                    if (action != null) action!
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
