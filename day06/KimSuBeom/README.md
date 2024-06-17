# 9장 전자액자

## 사전지식
### 위젯 생명주기
- 위젯이 화면에 그려지는 순간부터 삭제되는 순간까지의 주기
- StatelessWidget
    - 상태가 없는 위젯
    - StatelessWidget 빌드 -> 생성자가 실행 
        -> 필수로 오버라이드 해야 하는 build() 함수 실행
        -> 마지막으로 build() 함수에 반환한 위젯이 화면에 랜더링
    - 위젯의 속성을 변경 하려면 인스턴스를 아예 새로 생성한 후 기존 인스턴스를 대체해서 화면에 반영
- StatefulWidget
    - 위젯이 생성되고 build() 가 실행되기까지 과정은 StatelessWidget과 같음
    - 위젯 내부에서 자체적으로 build() 함수를 재실행 해야 할때 사용
    - 위젯 클래스와 스테이트 State 클래스 2개로 구성

    - 상태 변경이 없는 생명주기
        - 위젯이 화면에 나타나며 생성되고 화면에서 사라지고 삭제되는 과정, 중간에 위젯의 상태가 변경되지 않음
        - StatefulWidget 생성자 실행
            -> createState()함수가 실행 - 필수 오버라이드 함수, StatefulWidget과 연동되는 State 생성
            -> initState() 실행 - State 가 생성되는 순간에만 단 한번 실행
            -> didChangeDependencies() 가 실행 - BuildContext 가 제공되고 State 가 의존하는 값이 변경되면 재실행
            -> State 상태가 dirty로 설정 - build() 가 재실행 되야 하는 상태
            -> build() 함수가 실행되고 UI 반영
            -> 상태가 clean 상태로 변경
            -> 위젯이 위젯 트리에서 사라지면 deactivate() 가 실행 - State 가 일시 혹은 영구적으로 삭제될 때 실행
            -> dispose() 가 실행 - 위젯이 영구적으로 삭제될 때 실행
    - StatefulWidget 생성자의 매개변수가 변경됐을 때 생명주기
        - 위젯이 생성 후 삭제 되기 전 매개변수가 변경되면 실행
        - StatefulWidget 생성자 실행
            -> State의 didUpdateWidget() 함수 실행
            -> State 상태가 dirty 로 변경
            -> build() 실행
            -> State 상태 clean으로 변경
    - State 자체적으로 build()를 재실행할 때 생명주기
        - State 클래스는 setState() 함수를 실행해서 build() 함수를 재실행 할 수 있음
        - setDate() 실행
            -> State 상태가 dirty 로 변경
            -> build() 실행
            -> State 상태 clean으로 변경

### Timer
- 특정 시간이 지난 후에 일회성 또는 지속적으로 함수를 실행
- 생성자
    - Timer() : 기본 생성자
        - 첫번째 매개변수에 대기 기간을 Duration 으로 입력
        - 두번째 매개변수에 기간이 끝난 후 실행할 콜백 함수 입력
    - Timer.periodic() : Timer 의 유일한 네임드 생성자
        - 주기적으로 콜백 함수를 실행할 때 사용

## 사전준비
### pubspec.yaml 설정
- 프로젝트 의존성과 에셋을 등록하는 파일
- fultter 키에 assets 키를 작성하고 위치 지정, pub get
```dart
  assets:
    - asset/img/
```

## 구현하기
### 페이지뷰
- PageView 위젯은 material 패키지에서 기본 제공
- children 매개변수에 페이지로 생성하고 싶은 위젯을 넣음
- 이미지 핏fit 을 조절해서 전체 화면을 차지하도록 설정
- 상태바가 잘 보이도록 변경
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key?key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        children: [1,2,3,4,5].map(
          (number) => Image.asset('asset/img/image_$number.jpeg',
          fit: BoxFit.cover,
          ),
        ).toList(),

        ),     
    );
  }
}
```

### 타이머 추가
- StatelessWidget 이 아닌 StatefulWidget으로 변경
- build() 에 타이머를 등록하면 build() 함수가 실행될 때마다 새로운 Timer 생성 - 메모리 누수 발생
- initState()로 한번만 Timer 생성