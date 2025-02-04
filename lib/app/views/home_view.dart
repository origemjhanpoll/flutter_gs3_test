import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/card_widget.dart';
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
    final screen = MediaQuery.sizeOf(context);
    cardSize = Size(screen.width - PaddingSize.extraLarge, 140.0);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Meus Cartões'),
      ),
      body: Consumer<CardListViewModel>(
        builder: (context, viewModel, child) {
          final cards = viewModel.cards;
          final transactions = cards[viewModel.selectedCardIndex].transactions;

          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.isError) {
            return Center(child: Text(viewModel.error!));
          } else if (viewModel.isEmpty) {
            return Center(child: Text('Nenhum cartão encontrado.'));
          } else {
            return Column(
              children: [
                SizedBox(
                  height: cardSize.height,
                  child: ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: cards.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: PaddingSize.medium),
                    itemBuilder: (context, index) {
                      return CardWidget(
                        onTap: () => _onCardTap(index),
                        size: cardSize,
                        id: cards[index].id,
                        number: cards[index].number,
                        type: cards[index].type,
                        brand: cards[index].brand,
                        limitAvailable: cards[index].limitAvailable,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox.fromSize(
                      size: Size.fromWidth(PaddingSize.medium),
                    ),
                  ),
                ),
                Expanded(
                  child: transactions.isNotEmpty
                      ? ListView.builder(
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
}
