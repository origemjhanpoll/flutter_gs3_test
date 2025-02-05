import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String? title;
  const EmptyView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null
            ? Text(
                title!,
              )
            : null,
      ),
      body: SafeArea(
        child: Center(
          child: Text('Página vazia'),
        ),
      ),
    );
  }
}
