import 'package:flutter/material.dart';
import 'home.dart';

// open ios/Runner.xcworkspace
// flutter build apk --split-per-abi
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zielona',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData().copyWith(
          backgroundColor: Colors.transparent,
        ),
      ),
      home: const Home(),
    );
  }
}
