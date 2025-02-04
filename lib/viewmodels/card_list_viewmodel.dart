import 'package:flutter/material.dart';

import '../models/bank_card.dart';
import '../services/card_service.dart';

class CardListViewModel with ChangeNotifier {
  List<BankCard> _cards = [];
  bool _isLoading = false;
  String? _error;

  List<BankCard> get cards => _cards;
  bool get isLoading => _isLoading;
  bool get isEmpty => _cards.isEmpty;
  bool get isLoaded => _cards.isNotEmpty && _error == null;
  String? get error => _error;
  bool get isError => _error != null;

  final CardService _cardService = CardService();

  Future<void> loadCards() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cards = await _cardService.loadCards();
    } catch (e) {
      _error = 'Erro ao carregar os cartões: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
