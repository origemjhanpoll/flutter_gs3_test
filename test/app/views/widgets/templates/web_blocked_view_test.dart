import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/templates/web_blocked_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WebBlockedView => ', () {
    testWidgets('should renders all elements correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WebBlockedView(),
        ),
      );

      expect(find.byIcon(Icons.mobile_screen_share), findsOneWidget);

      expect(find.text('Este aplicativo não está disponível na versão Web.'),
          findsOneWidget);
      expect(find.text('Baixe o aplicativo móvel para continuar.'),
          findsOneWidget);

      expect(find.byType(SvgPicture), findsNWidgets(2));
    });
  });
}
