import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/home_view.dart';
import 'package:flutter_gs3_test/app/viewmodels/card_list_viewmodel.dart';
import 'package:flutter_gs3_test/app/views/widgets/organisms/card_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../sample/card_sample.dart';
import 'home_view_test.mocks.dart';

@GenerateMocks([CardListViewModel])
void main() {
  late MockCardListViewModel mockViewModel;

  setUpAll(() async {
    await initializeDateFormatting('pt_BR', null);
  });

  setUp(() {
    mockViewModel = MockCardListViewModel();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<CardListViewModel>.value(
        value: mockViewModel,
        child: const HomeView(),
      ),
    );
  }

  group('HomeView =>', () {
    testWidgets('should display loading indicator when loading',
        (tester) async {
      when(mockViewModel.isLoading).thenReturn(true);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.isEmpty).thenReturn(false);
      when(mockViewModel.error).thenReturn(null);
      when(mockViewModel.cards).thenReturn([]);
      when(mockViewModel.selectedCardIndex).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message when there is an error',
        (tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(true);
      when(mockViewModel.isEmpty).thenReturn(false);
      when(mockViewModel.error).thenReturn('Erro ao carregar cartões');
      when(mockViewModel.cards).thenReturn([]);
      when(mockViewModel.selectedCardIndex).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Erro ao carregar cartões'), findsOneWidget);
    });

    testWidgets('should display message when there are no cards',
        (tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.isEmpty).thenReturn(true);
      when(mockViewModel.error).thenReturn(null);
      when(mockViewModel.cards).thenReturn([]);
      when(mockViewModel.selectedCardIndex).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Nenhum cartão encontrado.'), findsOneWidget);
    });

    testWidgets('should display card list when cards are available',
        (tester) async {
      when(mockViewModel.isLoading).thenReturn(false);
      when(mockViewModel.isError).thenReturn(false);
      when(mockViewModel.isEmpty).thenReturn(false);
      when(mockViewModel.error).thenReturn(null);
      when(mockViewModel.cards).thenReturn([bankCardSample]);
      when(mockViewModel.selectedCardIndex).thenReturn(0);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CardListWidget), findsOneWidget);
    });
  });
}
