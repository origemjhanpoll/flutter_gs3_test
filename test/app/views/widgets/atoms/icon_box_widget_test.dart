import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/widgets/atoms/icon_box_widget.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IconBoxWidget =>', () {
    testWidgets('should render correctly with default values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: IconBoxWidget(asset: 'assets/icons/sample_icon.svg'),
          ),
        ),
      );

      final decoratedBoxFinder = find.byType(DecoratedBox);
      final paddingFinder = find.byType(Padding);
      final svgFinder = find.byType(SvgPicture);

      expect(decoratedBoxFinder, findsOneWidget);
      expect(paddingFinder, findsOneWidget);
      expect(svgFinder, findsOneWidget);

      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, EdgeInsets.all(PaddingSize.medium));
    });

    testWidgets('should apply custom borderRadius and padding', (tester) async {
      const customBorderRadius = 20.0;
      const customPadding = EdgeInsets.all(PaddingSize.large);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: IconBoxWidget(
              asset: 'assets/icons/sample_icon.svg',
              borderRadius: customBorderRadius,
              padding: customPadding,
            ),
          ),
        ),
      );

      final decoratedBox =
          tester.widget<DecoratedBox>(find.byType(DecoratedBox));
      final paddingWidget = tester.widget<Padding>(find.byType(Padding));

      expect((decoratedBox.decoration as BoxDecoration).borderRadius,
          BorderRadius.circular(customBorderRadius));
      expect(paddingWidget.padding, customPadding);
    });
  });
}
