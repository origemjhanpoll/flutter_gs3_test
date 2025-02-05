import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
    final theme = Theme.of(context);

    return ListTile(
      title: Text(merchant),
      subtitle: Text(_formatDate(date)),
      leading: DecoratedBox(
        decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: EdgeInsets.all(PaddingSize.small),
          child: SvgPicture.asset(
            _getCategoryIcon(category),
            colorFilter:
                ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
          ),
        ),
      ),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitleTextStyle:
          theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'R\$ $amount',
            style: theme.textTheme.titleMedium,
          ),
          if (installments > 1)
            Text(
              "em ${installments}x",
              style:
                  theme.textTheme.bodySmall!.copyWith(color: theme.hintColor),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd/MM 'às' HH:mm").format(date);
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "essential":
        return 'assets/icons/shopping.svg';
      case "entertainment":
        return 'assets/icons/entertainment.svg';
      case "transport":
        return 'assets/icons/transport.svg';
      default:
        return 'assets/icons/entertainment.svg';
    }
  }
}
