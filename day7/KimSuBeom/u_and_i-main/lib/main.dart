import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'sunflower',
          textTheme: TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.w700,
              fontFamily: 'parisienne',
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )),
      home: const HomeScreen(),
    );
  }
}
