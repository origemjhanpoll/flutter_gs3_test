import 'dart:convert';
import 'dart:io';

import 'package:flutter_gs3_test/app/models/card.dart';
import 'package:flutter_gs3_test/app/services/card_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../sample/card_sample.dart';
import 'card_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CardService cardService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    cardService = CardService(client: mockClient);
  });

  group('CardService =>', () {
    test('should return a list of BankCards when the request is successful',
        () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
            jsonEncode({
              "cards": [bankCardSample.toJson()],
            }),
            200),
      );

      final cards = await cardService.loadCards();

      expect(cards, isA<List<BankCard>>());
      expect(cards.length, 1);
      expect(cards.first, equals(bankCardSample));
    });

    test('should throw an HttpException when the request fails', () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(
        () async => await cardService.loadCards(),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
