# u_and_i

## 사전 지식
### setState() 함수
- State 를 상속하는 모든 클래스는 setState() 함수 사용 가능
- 함수 실행 과정
    - StateFulWidget의 랜더링이 끝나고 클린 상태
    - setState()를 실행해서 원하는 속성을 변경
    - 속성이 변경되고 위젯 상태가 더티dirty로 설정
    - build() 함수 재실행
    - State가 클린으로 돌아옴
- 매개변수 하나 입력 받음 => 콜백 함수
    - 해당 콜백 함수에 변경하고 싶은 속성 입력
    - 해당 코드 반영 후 build() 실행
    - 콜백 함수는 비동기로 작성되면 안됨
```dart
setState(() {
    number ++;

});

```

### showCupertinoDialog() 함수
- 다이얼로그 실행 함수
- iOS 스타일로 다이얼로그가 실행

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCupertinoDialog(
  context: context,
  barrierDismissible: true,
  builder: (BuildContext context){
    return Text('Dialog');
  },
);
```

## 구현하기
### 홈스크린 UI 구현하기
- 두 위젯을 위아래로 반씩 차지하게 배치
- 배경색을 적용하고 아래 위젯에 이미지 배치
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.pink[100], //배경색
      body: SafeArea(
        top: true,
        bottom:false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_DDAY(),
          _CoupleImage(),],
        ),
        ),
    );
  }
}

//상단 부분 DDAY 위젯
class _DDAY extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('DDay Widget');
  }
}

//하단부분 커플이미지 위젯
class _CoupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Image.asset(
      "asset/img/middle_image.png",
      height: MediaQuery.of(context).size.height/2,
      ),
    );
  }
}
```

### .of 생성자
- .of(context)로 정의된 모든 생성자는 일반적으로 BuildContext를 매개변수로 받음
- 위젯 트리에서 가장 가까이 있는 객체의 값을 찾아냄
  - MediaQuery.of(context) 는 가장 가까이 있는 MediaQuery 값을 찾아냄

### DDAY 위젯 임시 텍스트 설정
```dart
class _DDAY extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(height: 16,),
        Text('U&I'),
        const SizedBox(height: 16,),
        Text('우리 처음 만난 날'),
        const SizedBox(height: 16,),
        Text('2021.11.23'),
        const SizedBox(height: 16,),
        IconButton(onPressed: (){},
        icon: Icon(Icons.favorite,)
        ),
        const SizedBox(height: 16,),
        Text('D+365'),

      ],
    );
  }
}
```

### 텍스트 스타일 변경
- Flutter의 Material Design 3 (M3)에서는 텍스트 스타일의 명칭이 변경됨 
- 변경된 텍스트 스타일 명칭
    - headline1 → displayLarge
    - headline2 → displayMedium
    - headline3 → displaySmall
    - headline4 → headlineLarge
    - headline5 → headlineMedium
    - headline6 → headlineSmall
    - subtitle1 → titleLarge
    - subtitle2 → titleMedium
    - bodyText1 → bodyLarge
    - bodyText2 → bodyMedium
    - caption → bodySmall

```dart
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
```

### 오버플로 해결
  ![alt text](image.png)

- 위아래 나눈 위젯 상단 글자가 화면의 반 이상을 차지
  - 아래쪽 이미지가 남는 공간보다 더 많은 공간을 차지
  - 오버플로 overflow
- 해결책
  - 글자나 이미지를 임의로 조절
  - 이미지를 남는 공간만큼만 차지하도록 조정

```dart
  return Expanded(
    child: ...
  )
```

### 상태 관리 연습
- 하트 아이콘을 누르면 firstDay가 하루씩 늘어나게 작성
  - 버튼을 눌렀을때 GestureTapCallback 으로 실행 함수를 지정
  - 오늘 날짜를 변수로 받고 D-day를 그에 맞게 변경
  - 상위 onHeartPressed 함수가 실행될 때 setState()

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.pink[100], //배경색
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDAY(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }

  void onHeartPressed() {
    setState(() {
      firstDay = firstDay.subtract(Duration(days: 1));
    });
  }
}

//상단 부분 DDAY 위젯
class _DDAY extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  _DDAY({
    required this.onHeartPressed,
    required this.firstDay,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        IconButton(
            onPressed: onHeartPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            )),
        const SizedBox(
          height: 16,
        ),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}

//하단부분 커플이미지 위젯
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Center(
        child: Image.asset(
          "asset/img/middle_image.png",
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
```

