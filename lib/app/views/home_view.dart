import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/templates/empty_view.dart';
import 'package:flutter_gs3_test/core/shared/app_bar_widget.dart';
import 'package:flutter_gs3_test/core/shared/bottom_navigation_custom_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/card_list_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/favorite_list_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/molecules/header_widget.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/transaction_list_widget.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_gs3_test/core/utils/go_next_page.dart';
import 'package:flutter_gs3_test/core/shared/drawer_widget.dart';
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

    return Scaffold(
      extendBody: true,
      drawer: DrawerWidget(),
      appBar: AppBarWidget(),
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
                            FavoriteListWidget(
                              onTap: (item) =>
                                  goNewPage(title: item.text, context: context),
                            ),
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
