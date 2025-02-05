import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/empty_view.dart';
import 'package:flutter_gs3_test/app/views/widgets/card_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/my_favorites_widget.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_gs3_test/core/utils/format_date.dart';
import 'package:flutter_gs3_test/core/utils/go_next_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final PageController _pageController = PageController();
  late CardListViewModel viewModel;
  late Size cardSize;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<CardListViewModel>();
    _scrollController.addListener(_updateSelectedCardIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
      extendBody: true,
      drawer: Drawer(
        child: Center(
          child: Text.rich(
            TextSpan(
              text: 'Olá, ',
              children: [
                TextSpan(
                    text: 'Cliente',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.primaryColor),
        forceMaterialTransparency: true,
        centerTitle: true,
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
            onPressed: () => goNewPage(title: 'Mensagens', context: context),
            icon: Icon(Icons.message_outlined),
          ),
          IconButton(
            onPressed: () => goNewPage(title: 'Notificações', context: context),
            icon: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Consumer<CardListViewModel>(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: PaddingSize.medium),
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
                      padding: EdgeInsets.all(PaddingSize.medium)
                          .copyWith(bottom: 0),
                      child: Divider(height: 1),
                    ),
                    MyFavoritesWidget(
                        onTapItem: (item) =>
                            goNewPage(title: item, context: context),
                        onTap: () => goNewPage(
                            title: 'Meus favoritos', context: context)),
                    ListTile(
                      title: Text('Últimos lançamentos'),
                      contentPadding: EdgeInsets.zero.copyWith(
                          left: PaddingSize.medium, right: PaddingSize.small),
                      titleTextStyle: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      trailing: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () => goNewPage(
                            title: 'Últimos Lançamentos', context: context),
                        child: Padding(
                          padding: EdgeInsets.all(PaddingSize.small),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ver todos',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: theme.primaryColor),
                              ),
                              Icon(Icons.chevron_right,
                                  color: theme.primaryColor),
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
                                final showDate = index == 0 ||
                                    formatDate(transactions[index - 1].date) !=
                                        formatDate(transaction.date);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (showDate)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: PaddingSize.medium),
                                        child: Text(
                                          formatDate(transaction.date),
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    TransactionWidget(
                                      id: transaction.id,
                                      merchant: transaction.merchant,
                                      amount: transaction.amount,
                                      installments: transaction.installments,
                                      date: transaction.date,
                                      category: transaction.category,
                                    ),
                                  ],
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
          EmptyView(),
          EmptyView(),
          EmptyView(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
            child: BottomNavigationBar(
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              selectedItemColor: theme.primaryColor,
              unselectedItemColor: theme.hintColor,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset('assets/icons/tab-home.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tab-home.svg',
                    colorFilter:
                        ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Fatura',
                  icon: SvgPicture.asset('assets/icons/tab-invoice.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tab-invoice.svg',
                    colorFilter:
                        ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Cartão',
                  icon: SvgPicture.asset('assets/icons/tab-card.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tab-card.svg',
                    colorFilter:
                        ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Shop',
                  icon: SvgPicture.asset('assets/icons/tab-shop.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/tab-shop.svg',
                    colorFilter:
                        ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
        ),
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
