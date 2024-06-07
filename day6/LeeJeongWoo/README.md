# 단계 3 - 앱을 만들며 유용한 기능 익히기
## ch09 전자액자
### 9.1 사전 지식
9.1.1 위젯 생명주기
- StatelessWidget(상태가 없는 위젯)  
  - 실행순서  
    1. StatelessWidget 빌드
    2. 생성자 실행필수로 오버라이드해야하는 build() 함수 실행
    3. 마지막으로 build() 함수에 반환한 위젯이 화면에 렌더링
  - 위젯을 속성을 변경해야할 때 스테이트리스 위젯은 불변이기 때문에 한 번 생성된 인스턴스의 build() 함수는 재실행 되지 않음
  - 대신 인스턴스를 아예 새로 생성한 후 기존 인스턴스를 대체해서 변경 사항을 화면에 반영
- StatefulWidget
  - 외부에서 위젯 생성자의 매개변수를 변경해주면 위젯이 새롭게 생성되고 build() 함수가 실행되기까지 과정은 StatelessWidget 와 같음
  - 위젯 내부에서 자체적으로 build() 함수를 재실행해야하는 상황에 사용
  - 위젯 클래스와 스테이트 클래스 2개로 구성되어 있고 생명주기가 훨씬 복잡함
  
`StatefulWidget 에서 꼭 이해해야 하는 3가지 필수 생명주기`

- 상태 변경이 없는 생명주기
  - 위젯이 화면에 나타나며 생성되고 화면에서 사라지며 삭제되는 과정을 의미하며 중간에 위젯의 상태가 변경되지 않음
  - 실행순서  
    1. StatefulWidget 생성자 실행  
    2. createState() 함수 실행, StatefulWidget과 연동되는 State 생성  
    3. State 생성되면 initState() 실행(initState()는 State가 생성되는 순간에만 단 한번 실행되고 절대로 다시 실행되지 않음)
    4. didChangeDependencies()가 실행(initState()와 다르게 BuildContext가 제공되고 State가 의존하는 값이 변경되면 재실행)
    5. State의 상태가 dirty로 설정됨(dirty 상태는 build()가 재실행돼야 하는 상태)
    6. build() 함수가 실행되고 UI가 반영
    7. build() 실행이 완료되면 상태가 clean 상태로 변경, 화면에 변화가 없으면 이 상태를 유지
    8. 위젯이 위젯 트리에서 사라지면 deactive()가 실행(deactiver()는 State가 일시적 또는 영구적으로 삭제될 때 실행)
    9. dispose()가 실행(위젯이 영구적으로 삭제될 때 실행)

- StatefulWidget 생성자의 매개변수가 변경됐을 때 생명주기
  - 위젯이 생성된 후 삭제가 되기 전 매개변수가 변경되면 다음 생명주기가 실행
  - 실행순서  
    1. StatefulWidget 생성자 실행
    2. State의 didUpdateWidget() 함수가 실행
    3. State가 dirty 상태로 변경
    4. build()가 실행
    5. State의 상태가 clean으로 변경

- State 자체적으로 build()를 재실행할 때 생명주기
  - StatelessWidget은 생성될 때 build() 함수가 한번 실행되고 절대로 다시 실행되지 않음
  - 반면 StatefulWidget은 StatefulWidget 클래스와 State 클래스로 구성돼 있는데, State 클래스는 setState() 함수를 실행해서 build() 함수를 자체적으로 재실행할 수 있음
  - 실행순서
    1. setState()를 실행
    2. State가 dirty 상태로 변경
    3. build()가 실행
    4. State의 상태가 clean으로 변경

9.1.2 Timer
- 특정 시간이 지한 후에 일회성 또는 지속적으로 함수를 실행
- Timer.periodic()을 사용해서 주기적으로 콜백 함수를 실행(매개변수 2개를 입력받음)
- Timer의 생성자는 Timer(), Timer.periodic() 두가지
  - Timer() : Timer의 기본 생성자
  - Timer.periodic() : Timer의 유일한 네임드 생성자
  ```dart
  Timer.periodic(
    Duration(seconds: 3),   // 주기
    (timer) {},             // 콜백함수
  );
  ```
### 9.2 사전준비
- 프로젝트 생성
  - 프로젝트 이름 : image_carousel
  - 네이티브 언어: 코틀린, 스위프트

9.2.1 이미지 추가하기
- 예제 코드에서 그림을 가져와 asset/img/ 폴더를 생성 후 삽입  

9.2.2 pubspec.yaml 설정하기
```dart
// pubspec.yaml

flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:           // 에셋 등록 키
    - asset/img/    // 에셋으로 등록할 폴더 위치
```
9.2.3 프로젝트 초기화하기
```dart
// home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }
}
```
```dart
// main.dart

import 'package:image_carousel/screen/home_screen.dart';    // 추가해줌
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),   // HomeScreen을 홈 위젯으로 등록
    )
  );
}
```
### 9.3 레이아웃 구상하기
- 이번 프로젝트의 라이아웃은 좌우로 위젯을 스와이프할 수 있는 PageView 하나로 구성되어 있음
### 9.4 구현하기
9.4.1 페이지뷰 구현하기
```dart
// 9.4.1 페이지뷰 구현하기

// home_screen.dart

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(   // PageView 추가
        children: [1, 2, 3, 4, 5]   // 샘플 리스트 생성
          .map(   // 위젯으로 매핑
        (number) => Image.asset('asset/img/image_$number.jpeg'),
            )
            .toList(),
      ),  // 'Home Screen'),
    );
  }
}
```
```dart
// 9.4.1 페이지뷰 구현하기_여백없애기

// home_screen.dart

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(   // map() 함수는 1.4.1 map()을 참조
        children: [1, 2, 3, 4, 5]
            .map(   // 위젯으로 매핑
              (number) => Image.asset(
                  'asset/img/image_$number.jpeg',
                  fit: BoxFit.cover,  // BoxFit.cover 설정
              ),
        )
            .toList(),
      ),  // 'Home Screen'),
    );
  }
}
```
9.4.2 상태바 색상 변경하기
```dart
// 9.4.2 상태바 색상 변경하기

// home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';     // 추가해줌

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정으로 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(   // map() 함수는 1.4.1 map()을 참조
        children: [1, 2, 3, 4, 5]
            .map(   // 위젯으로 매핑
              (number) => Image.asset(
            'asset/img/image_$number.jpeg',
            fit: BoxFit.cover,  // BoxFit.cover 설정
          ),
        )
            .toList(),
      ),  // 'Home Screen'),
    );
  }
}
```
9.4.3 타이머 추가하기
```dart
// 9.4.3 타이머 추가하기

// home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// StatefulWidget 정의
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState 정의
class _HomeScreenState extends State<HomeScreen> {
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

  // PageController 생성
  final PageController pageController = PageController();

  // initState() 함수 등록
  @override
  void initState() {
    super.initState();  // 부모 initState() 실행

    Timer.periodic(     // Timer.periodic() 등록
      Duration(seconds: 3),
          (timer) {
          // print('실행!');

        // 현재 페이지 가져오기
        int?nextPage = pageController.page?.toInt();

        if (nextPage == null) {   // 페이지 값이 없을 때 예외 처리
          return;
        }

        if (nextPage == 4) {      // 첫 페이지와 마지막 페이지 분기 처리
          nextPage = 0;
        } else {
          nextPage++;
        }
        pageController.animateToPage( // 페이지 변경
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정으로 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(   // map() 함수는 1.4.1 map()을 참조
        controller: pageController,   // PageController 등록
        children: [1, 2, 3, 4, 5]
            .map(   // 위젯으로 매핑
              (number) => Image.asset(
            'asset/img/image_$number.jpeg',
            fit: BoxFit.cover,  // BoxFit.cover 설정
          ),
        )
            .toList(),
      ),
    );
  }
}
```