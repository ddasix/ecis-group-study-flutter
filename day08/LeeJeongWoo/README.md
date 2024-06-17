# 단계 3 - 앱을 만들면 유용한 기능 익히기
## ch11 디지털 주사위
### 11.1 사전지식
11.1.1 가속도계
- 특정 물체가 특정 방향으로 이동하는 가속도가 어느 정도인지를 숫자로 측정하는 기기
- 대부분의 핸드폰에 가속도계가 장착되어 있음
- 가속도계는 3개의 축으로 가속도를 측정할 수 있으며 x, y, z 축을 사용하며 측정 결과는 double 값 반환

`가속도계 3개의 축` 
- x축 : 좌우로 움직이는 방향
- y축 : 위아래로 움직이는 방향
- z축 : 앞뒤로 움직이는 방향

11.1.2 자이로스코프
- 가속도계는 x, y, z 축의 직선 움직임만 측정할 수 있어서 이를 보완한 자이로스코프는 회전을 측정할 수 있음

`자이로스코프 3개의 축`
- x축 : 좌우로 회전하는 방향
- y축 : 위아래로 회전하는 방향
- z축 : 앞뒤로 회전하는 방향

11.1.3 Sensor_Plus 패키지
- Sensor_Plus 패키지를 사용하면 핸드폰의 가속도계와 자이로스코프 센터를 간단하게 사용할 수 있음
- 가속도계와 자이로스코프 센서의 데이터는 x, y, z 축의 움직임을 각각 반환하기 때문에 수치화하는 정규화가 필요
- 따라서 미리 정규화 작업이 된 shake 패키지를 사용

```dart
// Sensor_Plus 패키지 예시

import 'package:sensors_plus/sensors_plus.dart';
... 생략 ...

// 중력을 반영한 가속도계 값
accelerometerEvents.listen((AccelerometerEvent event) {
  print(event.x); // x축 수치
  print(event.y); // y축 수치
  print(event.z); // z축 수치
});

// 중력을 반영하지 않은 순수 사용자의 힘에 의한 가속도계 값
userAccelerometerEvents.listen((UserAccelerometerEvent event) {
  print(event.x); // x축 수치
  print(event.y); // y축 수치
  print(event.z); // z축 수치
});

gyroscopeEvents.listen((GyroscopeEvent event) {
  print(event.x); // x축 수치
  print(event.y); // y축 수치
  print(event.z); // z축 수치
});
```

※ iOS는 16버전 이후 보안 때문에 더 이상 설정에 개발자모드를 지원하지 않음

### 11.2 사전 준비
- 프로젝트 생성
  - 프로젝트 이름 : random_dice
  - 네이티브 언어: 코틀린, 스위프트

11.2.1 상수 추가하기
- 프로젝트에 반복적으로 사용할 상수를 별도의 파일에 정리
```dart
// lib/const/colors.dart

import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF0E0E0E); // 배경색
const primaryColor = Colors.white; // 주색상
final secondaryColor = Colors.grey[600]; // 보조 색상
```
※ Color.grey는 const로 선언이 가능하지만, 600이라는 키값을 입력하면 런타임에 색상이 계산되므로 const 사용이 불가

11.2.2 이미지 추가하기
- 프로젝트 바로 아래에 asset/img 경로 폴더 생성 후 예제의 이미지파일들을 해당 경로에 삽입

11.2.3 pubspec.yaml 설정하기
- 아래 설정 추가 후 [pub.get] 실행
```dart
// pubspec.yaml

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.6
  shake: 2.2.0 // 흔들림을 감지하는 플러그임

flutter:
  uses-material-design: true

  assets:
    - asset/img/
```
11.2.4 프로젝트 초기화하기
- lib/screen 폴더 생성 후 home_screen.dart, root_screen.dart, settings_screen.dart 파일 생성

11.2.5 Theme 설정하기
- 상수를 사용한 테마 적용
```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/const/colors.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        sliderTheme: SliderThemeData(     // Slidar 위젯 관련 테마
          thumbColor: primaryColor,       // 노브 색상
          activeTrackColor: primaryColor, // 노브가 이동한 트랙 색상
          
          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withOpacity(0.3),
        ),
        // BottomNavigationBar 위젯 관련 테마
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,     // 선택 상태 색
          unselectedItemColor: secondaryColor, // 비선택 상태 색
          backgroundColor: backgroundColor,    // 배경색
        ),
      ),
      home: RootScreen(),   // HomeScreen을 RootScreen으로 변경
    ),
  );
}
```
### 11.3 레이아웃 구상하기
- 첫 번째 화면인 HomeScreen 위젯과 두 번째 화면인 SettingScreen을 TabBarView를 이용해서 RootScreen 위젯에 위치(RootScreen 하나에 탭으로 홈 스크린과 설정 스크린을 감싸고 있는 형태)

11.3.1 기본 스크린 위젯
- 모든 위젯을 담고 있는 최상위 위젯(RootScreen)
- 상단(TabBarView)과 하단(BottomNavigationBar)로 나눔
- TabBarView를 통해 선택된 화면을 보여줄 수 있음
- BottomNavigationBar에서 각 탭을 누르거나 TabBarView를 좌우로 스크롤 해서 화면 전환을 할 수 있음

11.3.2 홈 스크린 위젯
- Image 위젯과 Text 위젯을 사용하여 `주사위 이미지`, `행운의 숫자`, `주사위 눈금` 구현 

11.3.3 설정 스크린 위젯
- Text 위젯과 Slider 위젯을 사용하여 `민감도`, `슬라이더` 구현

### 11.4 구현하기
11.4.1 RootScreen 위젯 구현하기
- 생성한 root_screen.dart을 작성하고 main.dart 파일의 홈 화면을 RootScreen으로 변경
- RootScreen 은 TabBarView, BottomNavigationBar 두개로 구성
- TabBarView 작성
    - TabController 필수 사용
    - TabController를 초기화하기 위해 vsync 기능 사용
    - vsync 기능을 사용하기 위해 TickerProviderStateMixin 사용(애니메이션의 효율을 올려주는 역할)

- BottomNavigationBar에서 작성
    - BottomNavigationBar의 items 매개변수에 BottomNavigationBarItem이라는 클래스를 사용해서 각 탭의 정의를 제공해줘야 함
    - BottomNavigationBarItem의 icon 매개변수와 label 매개변수를 이용해서 구현할 두 탭을 작업
- BottomNavigationBar 구현 후 Tab1, Tab2 각 탭을 표현해줄 Container위젯들을 앞에 작성한 TabBarView의 renderChildren() 함수에 구현

- BottomNavigationBar를 누를 때마다 TabBarView와 연동

11.4.2 HomeScreen 위젯 구현하기
- Tab1 대신 주사위 이미지와 텍스트로 화면 구현

11.4.3 SettingScreen 위젯 구현
- lib/screen/setting_screen.dart 파일 작성
- Slidar 위젯은 눌러서 좌우로 움직일 때 움직인 만큼의 값이 제공되는 콜백 함수 실행(이 값을 저장하고 다시Slidar에 넣어주는게 주요 포인트)

11.4.4 shake 플러그인 적용하기
- 핸드폰을 흔들 때마다 매번 새로운 숫자가 생성되어야 하므로 HomeScreen 위젯의 number 매개변수에 들어갈 값을 number 변수로 상태 관리 하도록 코드를 변경

11.5 테스트하기
- 핸드폰을 흔들어서 주사위 이미지와 숫자가 변경되는지 확인
- 민감도 설정에 따라 높은 숫자일 경우 더 강하게 흔들어야 주사위 이미지와 숫자가 변경되는지 확인