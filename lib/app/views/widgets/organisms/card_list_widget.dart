import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/models/card.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';

import '../molecules/card_widget.dart';

class CardListWidget extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final ValueChanged<int>? onChange;
  final List<BankCard> cards;
  final int value;

  const CardListWidget({
    super.key,
    this.onTap,
    this.onChange,
    required this.cards,
    required this.value,
  });

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  final ScrollController _scrollController = ScrollController();
  late Size cardSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateSelectedCardIndex);
  }

  void _updateSelectedCardIndex() {
    final newIndex = (_scrollController.offset / cardSize.width).round();
    if (newIndex != widget.value && widget.onChange != null) {
      widget.onChange!(newIndex);
    }
  }

  void _onCardTap(int index) {
    widget.onTap?.call(index);
    if (index != widget.value) _scrollToIndex(index);
  }

  void _scrollToIndex(int index) {
    final double offset = index * cardSize.width;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateSelectedCardIndex);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.sizeOf(context);
    cardSize = Size(screen.width - PaddingSize.extraLarge, 140.0);

    return SizedBox(
      height: cardSize.height + PaddingSize.extraLarge,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.cards.length,
        padding: EdgeInsets.symmetric(horizontal: PaddingSize.medium),
        itemBuilder: (context, index) {
          final card = widget.cards[index];
          return CardWidget(
            onTap: () => _onCardTap(index),
            size: cardSize,
            color: _getBrandColor(card.brand, theme),
            id: card.id,
            number: card.number,
            bank: card.bank,
            type: card.type,
            brand: card.brand,
            limitAvailable: card.limitAvailable,
            bestPurchaseDay: card.bestPurchaseDay,
          );
        },
        separatorBuilder: (context, index) => SizedBox.fromSize(
          size: Size.fromWidth(PaddingSize.medium),
        ),
      ),
    );
  }
}

Color _getBrandColor(String brand, ThemeData theme) {
  switch (brand) {
    case 'Visa':
      return theme.primaryColor;
    case 'Mastercard':
      return const Color(0xFF00494B);
    default:
      return theme.colorScheme.primary;
  }
}
