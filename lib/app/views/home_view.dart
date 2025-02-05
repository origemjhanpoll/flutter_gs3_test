import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/card_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/my_favorites_widget.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:provider/provider.dart';
import '../viewmodels/card_list_viewmodel.dart';
import 'widgets/transaction_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  late CardListViewModel viewModel;

  late Size cardSize;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<CardListViewModel>();
    _scrollController.addListener(_updateSelectedCardIndex);
  }

  void _updateSelectedCardIndex() {
    final newIndex = (_scrollController.offset / cardSize.width).round();
    if (newIndex != viewModel.selectedCardIndex) {
      viewModel.setSelectedCardIndex(newIndex);
    }
  }

  void _onCardTap(int index) {
    if (index != viewModel.selectedCardIndex) {
      _scrollToIndex(index);
      Future.delayed(Duration(milliseconds: 300), () {
        viewModel.setSelectedCardIndex(index);
      });
    }
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

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
          color: theme.primaryColor,
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text.rich(
          TextSpan(
            text: 'Olá, ',
            children: [
              TextSpan(
                  text: 'Cliente',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        actions: [
          IconButton(
            color: theme.primaryColor,
            onPressed: () {},
            icon: Icon(Icons.message_outlined),
          ),
          IconButton(
            color: theme.primaryColor,
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Consumer<CardListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.isError) {
            return Center(child: Text(viewModel.error!));
          } else if (viewModel.isEmpty) {
            return Center(child: Text('Nenhum cartão encontrado.'));
          } else {
            final cards = viewModel.cards;
            final transactions =
                cards[viewModel.selectedCardIndex].transactions;

            return Column(
              children: [
                SizedBox(
                  height: cardSize.height + PaddingSize.extraLarge,
                  child: ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: cards.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: PaddingSize.medium),
                    itemBuilder: (context, index) {
                      final card = cards[index];
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
                ),
                Padding(
                  padding:
                      EdgeInsets.all(PaddingSize.medium).copyWith(bottom: 0),
                  child: Divider(height: 1),
                ),
                MyFavoritesWidget(),
                ListTile(
                  title: Text('Últimos lançamentos'),
                  contentPadding: EdgeInsets.zero.copyWith(
                      left: PaddingSize.medium, right: PaddingSize.small),
                  titleTextStyle: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  trailing: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(PaddingSize.small),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ver todos',
                            style: theme.textTheme.bodySmall,
                          ),
                          Icon(Icons.chevron_right, color: theme.primaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: transactions.isNotEmpty
                      ? ListView.separated(
                          itemCount: transactions.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return TransactionWidget(
                              id: transaction.id,
                              merchant: transaction.merchant,
                              amount: transaction.amount,
                              installments: transaction.installments,
                              date: transaction.date,
                              category: transaction.category,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Divider(indent: 16.0, endIndent: 16.0),
                        )
                      : Center(child: Text('Nenhum transação disponível.')),
                )
              ],
            );
          }
        },
      ),
    );
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
}
