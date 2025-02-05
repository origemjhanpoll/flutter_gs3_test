import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gs3_test/app/my_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Apenas modo retrato
  ]).then((_) {
    runApp(MyApp());
  });
}
