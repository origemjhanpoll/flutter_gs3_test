import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/card_list_viewmodel.dart';
import 'card_detail_view.dart';

class CardListView extends StatelessWidget {
  const CardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cartões'),
      ),
      body: ChangeNotifierProvider(
          create: (context) => CardListViewModel()..loadCards(),
          child: Consumer<CardListViewModel>(
            builder: (context, viewModel, child) {
              final viewModel = Provider.of<CardListViewModel>(context);

              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (viewModel.isError) {
                return Center(child: Text(viewModel.error!));
              } else if (viewModel.isEmpty) {
                return Center(child: Text('Nenhum cartão encontrado.'));
              } else {
                return ListView.builder(
                  itemCount: viewModel.cards.length,
                  itemBuilder: (context, index) {
                    final card = viewModel.cards[index];
                    return ListTile(
                      title: Text('Cartão ${card.number}'),
                      subtitle: Text('${card.brand} - ${card.type}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardDetailView(card: card),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
