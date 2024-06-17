import 'package:flutter/material.dart';
import 'package:random_dice/constants/colors.dart';
import 'package:random_dice/screens/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          sliderTheme: SliderThemeData(
            thumbColor: primaryColor,
            activeTrackColor: primaryColor,
            inactiveTrackColor: primaryColor.withOpacity(0.3),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryColor,
            backgroundColor: backgroundColor,
          )),
      home: const RootScreen(),
    );
  }
}
