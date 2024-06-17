# random_dice
## 사전 지식
### 가속도계
- 특정 물체가 특정 방향으로 이동하는 가속도가 어느정도인지 숫자로 측정하는 기기
- 3개의 축으로 가속도 측정 가능
- 가속도계로 움직임 이벤트를 받으면 x,y,z 축의 결과가 double 값으로 반환

### wkdlfhtmzhvm
- x,y,z 축의 회전을 측정
    - 가속도계는 직선 움직임만 측정
- 회전에 대한 이벤트를 받으면 x,y,z 축 모두에서 회전값이 동시에 반환

### Sensor_Plus 패키지
- 핸드폰에서 가속도계와 자이로스코프 센서를 간단하게 사용 가능
- 정규화가 필요

```dart
//pubspec.yaml
// sensors_plus: ^5.0.1

import 'package:sensors_plus/sensors_plus.dart'
 accelerometerEventStream().listen((AccelerometerEvent event) {
      print(event.x);
    });
    userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
      print(event.x);
    });
    gyroscopeEventStream().listen((GyroscopeEvent event) {
      print(event.x);
    });
```
## 사전 준비
### 테마설정
- 슬라이더 테마 속성
    - activeTrackColor: 활성 트랙의 색상.
    - inactiveTrackColor: 비활성 트랙의 색상.
    - trackShape: 트랙의 모양.
    - trackHeight: 트랙의 높이.
    - thumbColor: 슬라이더의 thumb(손잡이) 색상.
    - thumbShape: thumb(손잡이)의 모양.

```dart
 theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        //슬라이더 위젯 테마
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
```
### RootScreen 위젯 구현
- TabBarView 로 탭 화면 보여줄 위젯 생성
- BottomNavigationBar : Tab을 조정할 수 있는 UI를 핸드폰 아래 배치 가능
- TickerProviderMixin
  - 애니메이션 효율 담당
  - 한 틱(1FPS) 마다 애니메이션 실행
  - TabController 도 vsync d에 해당 제공