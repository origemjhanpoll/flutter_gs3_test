import 'package:flutter/material.dart';
import 'package:flutter_gs3_test/app/viewmodels/card_list_viewmodel.dart';
import 'package:flutter_gs3_test/app/views/home_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Cartões',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
          create: (context) => CardListViewModel()..loadCards(),
          child: HomeView()),
    );
  }
}
