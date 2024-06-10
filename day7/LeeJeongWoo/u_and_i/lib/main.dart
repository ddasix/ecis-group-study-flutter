import 'package:u_and_i/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData( // 테마를 지정할 수 있는 클래스
        fontFamily: 'sunflower',  // 기본 글씨체

        textTheme: TextTheme(     // 글자 테마를 적용할 수 있는 클래스
          headlineLarge: TextStyle(   // headline1 스타일 정의
            color: Colors.white,  // 글 색상
            fontSize: 80.0,       // 크기
            fontWeight: FontWeight.w700,  // 글 두께
            fontFamily: 'parisienne',     // 글씨체
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      home: HomeScreen(),
    ),
  );
}