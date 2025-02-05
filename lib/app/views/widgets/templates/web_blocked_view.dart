import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/core/constants/padding_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WebBlockedView extends StatelessWidget {
  const WebBlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(PaddingSize.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: PaddingSize.small,
            children: [
              Icon(
                Icons.mobile_screen_share,
                size: 80,
                color: theme.primaryColor,
              ),
              Text(
                'Este aplicativo não está disponível na versão Web.',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text('Baixe o aplicativo móvel para continuar.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge),
              SizedBox(height: PaddingSize.small),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: PaddingSize.medium,
                children: [
                  SvgPicture.asset('assets/logos/applestore-light.svg'),
                  SvgPicture.asset('assets/logos/playstore-light.svg'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
