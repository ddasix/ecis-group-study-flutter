import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  // flutter가 자동으로 바인딩을 하고 앱이 실행준비가 되면 runApp이 실행이 되지만
  // Stateless 내부에서 위젯들을 인스턴스화 하기 위해 `WidgetsFlutterBinding.ensureInitialized();` 추가 해야 함.
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
