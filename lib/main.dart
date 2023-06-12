import 'package:book_store/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          home: SplashScreen(),
        );
      }),
    );
  }
}
