import 'package:flutter/material.dart';
import 'package:u_and_i/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Sunflower',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Parisienne',
            fontSize: 80.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
