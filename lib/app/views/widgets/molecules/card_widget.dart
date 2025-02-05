import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatefulWidget {
  final int id;
  final String number;
  final String bank;
  final String type;
  final String brand;
  final String limitAvailable;
  final int? bestPurchaseDay;
  final Size size;
  final Color color;
  final VoidCallback? onTap;

  const CardWidget({
    super.key,
    required this.id,
    required this.number,
    required this.bank,
    required this.type,
    required this.brand,
    required this.limitAvailable,
    this.bestPurchaseDay,
    required this.size,
    required this.color,
    this.onTap,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool limitAvailableIsVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorContrast = _getContrastColor(widget.color);
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox.fromSize(
        size: widget.size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.color, _darkenColor(widget.color)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: PaddingSize.medium),
            child: Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    _getBrandIcon(widget.brand),
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 54,
                  ),
                  contentPadding: EdgeInsets.all(PaddingSize.medium),
                  title: Text('●●●● ${widget.number}'),
                  subtitle: Text(widget.bank),
                  titleTextStyle: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: colorContrast),
                  subtitleTextStyle:
                      theme.textTheme.bodyLarge!.copyWith(color: colorContrast),
                  trailing: IconButton(
                      color: colorContrast,
                      onPressed: () {
                        setState(() {
                          limitAvailableIsVisible = !limitAvailableIsVisible;
                        });
                      },
                      icon: Icon(
                        limitAvailableIsVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorContrast.withValues(alpha: 0.1),
                        colorContrast.withValues(alpha: 0.1)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1.5,
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: ListTile(
                          title: Text('Limite disponível'),
                          subtitle: Text(limitAvailableIsVisible
                              ? "R\$ ${widget.limitAvailable}"
                              : "●●●●"),
                          titleTextStyle: theme.textTheme.bodySmall!.copyWith(
                              color: colorContrast.withValues(alpha: 0.8)),
                          subtitleTextStyle: theme.textTheme.titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorContrast),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            'Melhor dia de compra',
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            widget.bestPurchaseDay.toString(),
                            textAlign: TextAlign.right,
                          ),
                          titleTextStyle: theme.textTheme.bodySmall!.copyWith(
                              color: colorContrast.withValues(alpha: 0.8)),
                          subtitleTextStyle: theme.textTheme.titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorContrast),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getContrastColor(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  Color _darkenColor(Color color, {double amount = 0.2}) {
    final hsl = HSLColor.fromColor(color);
    final darkerHsl =
        hsl.withLightness((hsl.lightness - amount).clamp(0.1, 1.0));
    return darkerHsl.toColor();
  }

  String _getBrandIcon(String brand) {
    switch (brand) {
      case 'Visa':
        return 'assets/icons/visa.svg';
      case 'Mastercard':
        return 'assets/icons/mastercard.svg';
      default:
        return 'assets/icons/visa.svg';
    }
  }
}
