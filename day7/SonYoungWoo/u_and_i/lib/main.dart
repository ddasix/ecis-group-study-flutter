import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    ///테마 클래스
    ///선언해 놓으면 자식 위젯에 적용할 수 있음.
    theme: ThemeData(
        fontFamily: "sunflower",  // pubspec에 지정한 폰트 이름
        textTheme: const TextTheme(     // 폰트 테마
            ///스타일 이름 교재 p.252 에는 headline1으로 되어있는데 바뀐듯
            headlineLarge : TextStyle(
            color: Colors.white,  //  글 색상
            fontSize: 80.0,       //  글 크기
            fontWeight: FontWeight.w700, //  글 두께
            fontFamily: 'parisienne',    //  pubspec에 지정한 폰트 이름
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
        )
    ),
    home:HomeScreen(),
  ));
}
 
