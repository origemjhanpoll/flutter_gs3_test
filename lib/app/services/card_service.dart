import 'dart:convert';
import 'dart:io';

import 'package:flutter_gs3_test/app/models/card.dart';
import 'package:http/http.dart' as http;

class CardService {
  final http.Client client;

  CardService({required this.client});

  final String _url =
      'https://raw.githubusercontent.com/origemjhanpoll/flutter_GS3_test/refs/heads/main/test/json/response.json';

  Future<List<BankCard>> loadCards() async {
    final response = await client.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final cards = (jsonData['cards'] as List)
          .map((cardJson) => BankCard.fromJson(cardJson))
          .toList();
      return cards;
    } else {
      throw HttpException('Falha ao carregar os cartões');
    }
  }
}
