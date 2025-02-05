import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/views/empty_view.dart';

void goNewPage({required String title, required BuildContext context}) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => EmptyView(title: title)));
}
