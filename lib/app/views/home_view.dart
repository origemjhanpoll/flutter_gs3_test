import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/empty_view.dart';
import 'package:flutter_gs3_test/app/views/widgets/bottom_navigation_custom_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/card_list_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/favorites_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/header_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/transaction_list_widget.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_gs3_test/core/utils/go_next_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../viewmodels/card_list_viewmodel.dart';

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
  }

  void _updateListTransaction(int index) {
    viewModel.setSelectedCardIndex(index);
    _scrollController.animateTo(
      140.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNavigationTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    viewModel.dispose();
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
                    CardListWidget(
                      cards: cards,
                      value: viewModel.selectedCardIndex,
                      onChange: _updateListTransaction,
                    ),
                    Divider(
                      indent: PaddingSize.medium,
                      endIndent: PaddingSize.medium,
                      height: PaddingSize.large,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            HeaderWidget(
                              onTap: () => goNewPage(
                                  title: 'Meus Favoritos', context: context),
                              title: 'Meus favoritos',
                              actionText: 'Personalizar',
                              action: SvgPicture.asset(
                                'assets/icons/more.svg',
                                width: 18.0,
                                height: 18.0,
                                colorFilter: ColorFilter.mode(
                                    theme.colorScheme.primary, BlendMode.srcIn),
                              ),
                            ),
                            FavoritesWidget(
                                onTapItem: (item) =>
                                    goNewPage(title: item, context: context),
                                onTap: () => goNewPage(
                                    title: 'Meus favoritos', context: context)),
                            HeaderWidget(
                              onTap: () => goNewPage(
                                  title: 'Últimos lançamentos',
                                  context: context),
                              title: 'Últimos lançamentos',
                              actionText: 'Ver todos',
                              action: Icon(Icons.chevron_right,
                                  color: theme.primaryColor),
                            ),
                            transactions.isNotEmpty
                                ? TransactionListWidget(
                                    transactions: transactions,
                                  )
                                : Center(
                                    child: Text('Nenhum transação disponível.'))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          EmptyView(
            text: 'Párgina de Faturas',
            asset: 'assets/icons/tab-invoice.svg',
          ),
          EmptyView(
            text: 'Párgina de Cartões',
            asset: 'assets/icons/tab-card.svg',
          ),
          EmptyView(
            text: 'Párgina de Compras',
            asset: 'assets/icons/tab-shop.svg',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationCustomWidget(
        currentIndex: _selectedIndex,
        onTap: (index) => _onNavigationTapped(index),
      ),
    );
  }
}
