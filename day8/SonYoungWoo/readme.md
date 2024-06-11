# Chapter 11. 디지털 주사위
## 사전지식
### 가속도계
- 특정물체가 특정방향으로 이동하는 속도를 숫자로 측정하는 기기.
- x :좌우,y:위아래,z:앞뒤 로 움직일때 측정결과가 double로 반환.
### 자이로스코프
- x,y,z축의 회전을 측정.
- 모든축에 대하여 회전값을 동시 반환
### Sensor_Plus 패키지
- 가속도와 자이로스코프를 사용하기위해서는 Sensor_Plus 패키지 필요.
- 실제 사용할 수 있는 측정값을 얻기 위해서는 정규화가 필요.(shake 패키지 이용)

### pubspec.yaml 설정
- Sensor_Plus 패키지 등록
- shake: ^2.2.0 설정  
 

## main 구현
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';
import 'package:random_dice/screen/root_screen.dart';

void main() {
  runApp(
     MaterialApp(
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
        ),
      ),
      home:const RootScreen(),
    )
  );
}
```

## home_screen 구현
```dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_dice/const/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number;

  const HomeScreen({
    super.key,
    required this.number,
  });
  
  @override
  Widget build(BuildContext context) {
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("asset/img/$number.png"),
          ),
          SizedBox(height: 30,),
          Text(
            "행운의 숫자",
             style: TextStyle(
               color: primaryColor,
               fontSize: 20,
               fontWeight: FontWeight.w700
             ),
          ),
          SizedBox(height: 12,),
          Text(
            number.toString(),
            style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
        ],
      );
  }
 
}
```

## root_screen 구현
```dart
import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';


class RootScreen extends StatefulWidget{

  const RootScreen({super.key});
 
  @override
  State<StatefulWidget> createState() => _RootScreenState();

}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState()
  {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
        shakeSlopTimeMS: 100,
        shakeThresholdGravity: threshold,
        onPhoneShake: onPhoneShake,);

  }

  void onPhoneShake(){
    final rand = new Random();
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {   
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  TabBarView(
        controller: controller,
        children: renderChildren(),
        ),
        bottomNavigationBar: renderBottomNavigation(),
    );
  }

 
 List<Widget> renderChildren(){
  return [
    HomeScreen(number: number),
    SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange),
  ];
 }

 void onThresholdChange(double val)
 {
   setState(() {
     threshold = val;
   });
 }

 BottomNavigationBar renderBottomNavigation(){
   return BottomNavigationBar(
     currentIndex: controller!.index,
     onTap: (int index){
       setState(() {
         controller!.animateTo(index);
       });
     },
     items: const [
       BottomNavigationBarItem(icon: Icon(
         Icons.edgesensor_high_outlined,
       ),
         label: "주사위",
       ),
       BottomNavigationBarItem(icon: Icon(
         Icons.settings,
       ),
         label: "설정",
       ),
     ],
   );
 }
}
```


## settings_screen 구현
```dart
import 'package:random_dice/const/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget{
  final double threshold;
  final ValueChanged<double> onThresholdChange;

  const SettingsScreen({
    Key? key,
    // threshold와 onThresholdChange는 SettingsScreen에서 입력
    required this.threshold,
    required this.onThresholdChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                '민감도',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 0.1,  
          max: 10.0,   
          divisions: 101,  
          value: threshold,  
          onChanged: onThresholdChange,  
          label: threshold.toStringAsFixed(1), 
        ),
      ],
    );
  }

}
```
