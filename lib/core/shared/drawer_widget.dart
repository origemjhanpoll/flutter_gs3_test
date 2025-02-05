import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'Olá, ',
            children: [
              TextSpan(
                  text: 'Cliente',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
