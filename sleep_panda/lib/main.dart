import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sleep_panda/screens/splash.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
