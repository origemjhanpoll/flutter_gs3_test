import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/utils/go_next_page.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      iconTheme: IconThemeData(color: theme.primaryColor),
      forceMaterialTransparency: true,
      centerTitle: true,
      title: Text.rich(
        TextSpan(
          text: 'Olá, ',
          children: [
            TextSpan(
                text: 'Cliente', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => goNewPage(title: 'Mensagens', context: context),
          icon: Icon(Icons.message_outlined),
        ),
        IconButton(
          onPressed: () => goNewPage(title: 'Notificações', context: context),
          icon: Icon(Icons.notifications_none),
        )
      ],
    );
  }
}
