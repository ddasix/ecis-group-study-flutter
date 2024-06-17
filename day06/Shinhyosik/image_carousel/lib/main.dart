import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_carousel/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final images = [
      'image_1.jpeg',
      'image_2.jpeg',
      'image_3.jpeg',
      'image_4.jpeg',
      'image_5.jpeg',
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(
        images: images,
      ),
    );
  }
}
