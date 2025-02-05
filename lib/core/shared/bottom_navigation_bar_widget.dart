import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final int currentIndex;
  const BottomNavigationBarWidget({
    super.key,
    this.onTap,
    this.currentIndex = 0,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
          child: BottomNavigationBar(
            onTap: widget.onTap,
            currentIndex: widget.currentIndex,
            selectedItemColor: theme.primaryColor,
            unselectedItemColor: theme.hintColor,
            type: BottomNavigationBarType.fixed,
            items: [
              buildBottomNavItem(
                label: 'Home',
                assetPath: 'assets/icons/tab-home.svg',
                theme: theme,
              ),
              buildBottomNavItem(
                label: 'Fatura',
                assetPath: 'assets/icons/tab-invoice.svg',
                theme: theme,
              ),
              buildBottomNavItem(
                label: 'Cartão',
                assetPath: 'assets/icons/tab-card.svg',
                theme: theme,
              ),
              buildBottomNavItem(
                label: 'Shop',
                assetPath: 'assets/icons/tab-shop.svg',
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem buildBottomNavItem({
  required String label,
  required String assetPath,
  required ThemeData theme,
}) {
  return BottomNavigationBarItem(
    label: label,
    icon: SvgPicture.asset(assetPath),
    activeIcon: SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
    ),
  );
}
