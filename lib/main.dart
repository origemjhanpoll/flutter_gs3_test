import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gs3_test/app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Apenas modo retrato
  ]).then((_) {
    runApp(MyApp());
  });
}
