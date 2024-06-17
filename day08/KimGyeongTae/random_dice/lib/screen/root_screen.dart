import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  TabController? controller;    // 사용할 TabController 선언
  double threshold = 2.7;       // 민감도의 기본값
  int number = 1;               // 처음 주사위 숫자
  ShakeDetector? shakeDetector; // shake 플러그인 사용

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);

    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(   // 흔들기 감지 즉시 시작
      shakeSlopTimeMS: 100,  // 감지 주기
      shakeThresholdGravity: threshold,  // 감지 민감도
      onPhoneShake: onPhoneShake,  // 감지 후 실행할 함수
    );
  }

  // slider 민감도 감지 후 실행할 함수
  void onPhoneShake() {
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1; // 난수는 0 부터 생성
    });
  }

  // tab listener로 사용할 함수
  tabListener() {
    setState(() {});
  }

  @override
  dispose(){
    controller!.removeListener(tabListener); // tab listener에 등록한 함수 등록 취소
    shakeDetector!.stopListening(); // onPhoneShake 가 실행되지 않도록 listener 제거
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(  // 탭 화면을 보여줄 위젯
        controller: controller,
        children: renderChildren(),
      ),

      // 아래 탭 네비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }
  /*
  List<Widget> renderChildren(){
    return [
      Container(
        child: Center(
          child: Text(
            'Tab 1',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        child: Center(
          child: Text(
            'Tab 2',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }
  */

  List<Widget> renderChildren(){
    return [
      HomeScreen(number: number),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
    ];
  }

  void onThresholdChange(double val){  // 슬라이더값 변경 시 실행 함수
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {  // 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(  // 하단 탭바의 각 버튼을 구현
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }
}