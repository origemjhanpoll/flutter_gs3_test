import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bank_card.dart';

class CardService {
  final String _url = 'https://sua-url-aqui.com/cards.json';

  Future<List<BankCard>> loadCards() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final cards = (jsonData['cards'] as List)
          .map((cardJson) => BankCard.fromJson(cardJson))
          .toList();
      return cards;
    } else {
      throw Exception('Falha ao carregar os cartões');
    }
  }
}
