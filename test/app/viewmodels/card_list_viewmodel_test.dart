import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_gs3_test/app/viewmodels/card_list_viewmodel.dart';
import 'package:flutter_gs3_test/app/services/card_service.dart';

import '../../sample/card_sample.dart';
import 'card_list_viewmodel_test.mocks.dart';

@GenerateMocks([CardService])
void main() {
  late MockCardService mockCardService;
  late CardListViewModel viewModel;

  setUp(() {
    mockCardService = MockCardService();
    viewModel = CardListViewModel(cardService: mockCardService);
  });

  group('CardListViewModel =>', () {
    test('should initialize with correct default values', () {
      expect(viewModel.cards, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.isEmpty, isTrue);
      expect(viewModel.isLoaded, isFalse);
      expect(viewModel.error, isNull);
      expect(viewModel.isError, isFalse);
      expect(viewModel.selectedCardIndex, 0);
    });

    test('should load cards successfully', () async {
      when(mockCardService.loadCards())
          .thenAnswer((_) async => [bankCardSample]);

      await viewModel.loadCards();

      expect(viewModel.cards, isNotEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.isLoaded, isTrue);
      expect(viewModel.error, isNull);
    });

    test('should handle error when loading cards', () async {
      when(mockCardService.loadCards())
          .thenThrow(HttpException('Erro ao buscar cartões'));

      await viewModel.loadCards();

      expect(viewModel.cards, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.isError, isTrue);
      expect(viewModel.error, 'Erro ao buscar cartões');
    });

    test('should update selected card index', () {
      viewModel.setSelectedCardIndex(2);
      expect(viewModel.selectedCardIndex, 2);
    });
  });
}
