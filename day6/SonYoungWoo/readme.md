# Chapter 09. 전자액자

##  사전지식
### 위젯 생명주기
- StatelessWidget : 상태가 없는 위젯. 생성자가 실행되어서 build 함수 실행.
- StatefulWidget : 위젯 클래스와 스테이트 클래스 2개로 구성.
 
- 상태변경이 없는 생명주기 화면에 나타나면서 생성, 사라지면서 삭제.
  1. StatefulWidget 생성자로 createState() 함수실행
  2. initState() State가 생성되는 한번만 실행
  3. didChangeDependencies() State가 의존하는 값이 변경되면 재실행
  4. State 상태 dirty 로 변경
  5. 상태가 dirty 면 build 실행해서 UI가 반영
  6. build가완료되면 clean 상태로 변경(화면유지)
  7. 위젯이 일시적 혹은 영구적 상제될때 deactivate() 실행
  8. 완전이 삭제될때 dispose() 실행
- 매개변수가 변경되었을때 생명주기
  1. StatefulWidget 생성자 실행
  2. State의 didUpdateWidget 함수 실행
  3. State 상태 dirty 로 변경
  4. 상태가 dirty 면 build 실행해서 UI가 반영
  5. build가완료되면 clean 상태로 변경(화면유지)
- State 자재적으로 build를 재실행 할때 생명주기
  1. setState() 함수실행
  2. State 상태 dirty 로 변경
  3. State 상태 dirty 로 변경
  4. 상태가 dirty 면 build 실행해서 UI가 반영
### timer
- 일정 시간이 지난 후에 함수를 실행
- 실행주기, 콜백함수를 이용.

## 사전준비
### asset 설정
- 사용할 이미지를 asset / img 폴더 생성 후 추가
### pubspec.yaml 설정
- 추가된 파일을 pubspec.yaml파일에 설정
- pub get 기능을 사용하여 적용.

  
## 구현하기
### 페이지뷰
- 여러개의 위젯을 단독페이지에 생성하고 페이지를 넘길 수 있게 하는 위젯
- pageview를 추가하고 리스트로 asset에 추가된 파일들을 map 형식으로 설정.
- 화면비율에 맞추기 위하여 Boxfit.cover로 전체화면을 차지하도록 설정.
- 상태바 색상을 잘보이도록 
```dart
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class HomeScreen extends StatelessWidget{
 
HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
     return  Scaffold(
      body: PageView(
        children: [1,2,3,4,5].map((number)=> Image.asset("asset/img/image_$number.jpeg",fit:BoxFit.cover,),).toList(),

      ),
     );
  }
}
```
### 타이머 추가
- 기존 HomeScreen을 SatatuefulWidget으로 변경.
 
