import 'dart:io';
import 'package:flutter/material.dart';
import '../models/card.dart';
import '../services/card_service.dart';
import 'package:http/http.dart' as http;

class CardListViewModel with ChangeNotifier {
  List<BankCard> _cards = [];
  bool _isLoading = false;
  String? _error;
  int _selectedCardIndex = 0;

  List<BankCard> get cards => _cards;
  bool get isLoading => _isLoading;
  bool get isEmpty => _cards.isEmpty;
  bool get isLoaded => _cards.isNotEmpty && _error == null;
  String? get error => _error;
  bool get isError => _error != null;
  int get selectedCardIndex => _selectedCardIndex;

  final CardService _cardService;

  CardListViewModel({CardService? cardService})
      : _cardService = cardService ?? CardService(client: http.Client());

  Future<void> loadCards() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cards = await _cardService.loadCards();
    } on HttpException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Erro ao carregar os cartões: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedCardIndex(int index) {
    _selectedCardIndex = index;
    notifyListeners();
  }
}
