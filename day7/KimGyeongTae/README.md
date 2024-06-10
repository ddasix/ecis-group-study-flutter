# Dart 앱을 만들며 유용한 기능 익히기
## 10. 만난 지 며칠 U&I
### 10.1 사전 지식 
#### 10.1.1 setState() 함수
- State 를 상속하는 모든 클래스는 setState() 함수를 사용할 수 있다
- setState() 함수가 실행되는 5단계
1. 클린 상태 : 클린 상태에서 상태를 변경해줘야 한다
2. setState() : setState() 를 실행해서 원하는 속성들을 변경
3. 더티 상태 : 속성이 변경되고 위젯의 상태가 더티로 설정 된다
4. build() : build() 함수가 재실행
5. 클린 상태 : State 가 클린 상태로 다시 되돌아 온다
- setState() 함수는 매개변수로 콜백 함수를 입력 받는다
- 콜백 함수가 비동기로 작성되면 안 된다는 점에 주의
    ```dart
    setState(() {
      number++;
    });
    ```    
#### 10.1.2 ShowCupertinoDialog() 함수
- iOS 스타일로 다이얼로그가 실행되는 함수
    ```dart
    import 'package:flutter/cupertino.dart';

    showCupertinoDialog(
      context: context, // BuildContext 입력
      barrierDismissible: true, // 외부 탭해서 닫을 수 있음
      builder: (BuildContext context) { // 다이얼로그에 들어갈 위젯
        return Text('Dialog');
      },
    );
    ```  
### 10.2 사전 준비
#### 10.2.1 이미지와 폰트 추가하기
- [asset] - [font]
- [asset] - [img]
#### 10.2.2 pubspec.yaml 설정하기
- main.dart
    ```dart
    flutter:
      uses-material-design: true
    
      assets:
        - asset/img/

      fonts:
        - family: parisienne  # family 키에 폰트 이름을 지정할 수 있습니다.
          fonts:
            - asset: asset/font/Parisienne-Regular.ttf  # 등록할 폰트 파일의 위치

        - family: sunflower
          fonts:
            - asset: asset/font/Sunflower-Light.ttf
            - asset: asset/font/Sunflower-Medium.ttf
              weight: 500  # 폰트의 두께. FontWeight 클래스의 값과 같습니다.
            - asset: asset/font/Sunflower-Bold.ttf
              weight: 700
    ```
#### 10.2.3 프로젝트 초기화하기
- [screen] - home_screen.dart 생성
### 10.3 레이아웃 구상하기
- _DDay, _CoupleImage 위젯 두가지를 위아래로 나누어서 구현
### 10.4 구현하기
- UI 구현 > 상태 관리 구현 > 날짜 선택 기능 구현 순서
#### 10.4.1 홈 스크린 UI 구현하기
- _DDay 위젯 구현
- _CoupleImage 위젯 구현
- _DDay 위젯처럼 이름 첫 글자가 언더스코어이면 다른 파일에서 접근할 수 없다
- mainAxisAlignment: MainAxisAlignment.spaceBetween : 위아래 끝에 위젯 배치
- crossAxisAlignment: CrossAxisAlignment.stretch : 반대축 최대 크기로 늘리기
    ```dart
    child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(),
            _CoupleImage(),
          ],
    ),
    ```
- _CoupleImage 위젯에 커플 이미지 적용
- 이미지의 높이를 화면 높이의 반만큼으로 조절
    ```dart
    child: Image.asset(
          'asset/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
    ),
    ```
- ThemeData 매개변수
  - fontFamily : 기본 글씨체를 지정
  - textTheme : Text 위젯 테마를 지정
  - tabBarTheme : TabBar 위젯의 테마를 지정
  - cardTheme : Card 위젯의 테마를 지정
  - appBarTheme : AppBar 위젯의 테마를 지정
  - floatingActionButtonTheme : FloatingActionButton 위젯의 테마를 지정
  - elevatedButtonTheme : ElevatedButton 위젯의 테마를 지정
  - checkboxTheme : Checkbox 위젯의 테마를 지정
#### 10.4.2 상태 관리 연습해보기
- StatefulWidget 에서 setState() 함수를 사용해서 상태 관리를 하는 방법 학습
1. HomeScreen 을 StatefulWidget 으로 변경
    ```dart
    class HomeScreen extends StatelessWidget
    ```
2. 오늘을 기준으로 변수 선언
    ```dart
    class _HomeScreenState extends State<HomeScreen> {
      DateTime firstDay = DateTime.now();
    ```
3. _DDay 위젯에 하트 아이콘을 눌렀을 때 실행되는 콜백 함수를 매개변수로 노출해서 
    _HomeScreenState 에서 상태 관리를 하도록 한다
4. 하트 아이콘을 클릭해본다
5. firstDay 변수를 기반으로 날짜와 D-Day 가 렌더링되게 한다
6. 저장하고 핫 리로드
    ```dart
    children: [
            _DDay(

              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
    ```  
    ```dart
    void onHeartPressed(){  
    ```   
    ```dart
    final GestureTapCallback onHeartPressed;
    final DateTime firstDay;

    _DDay({
      required this.onHeartPressed,  
      required this.firstDay,
    });

    IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
    ``` 
7. setState() 함수를 사용.
     상태 관리 테스트로 하트 아이콘 누르면 firstDar 가 하루씩 늘어나는 기능 추가
    ```dart
    void onHeartPressed(){
      setState(() {
        firstDay = firstDay.subtract(Duration(days: 1));
      });
    }
    ```
#### 10.4.3 CupertinoDatePicker 로 날짜 선택 구현하기
- 아이콘을 클릭하면 날짜를 선택할 수 있는 CupertinoDatePicker 가 화면에 생성되도록 구현
- showCupertinoDialog() 함수와 CupertinoDatePicker 위젯 사용
- CupertinoDatePicker 는 Cupertino 패키지에서 기본으로 제공하는 위젯
   - 정해진 값을 onDateTimeChanged 콜백 함수의 매개변수로 전달
   - CupertinoDatePickerMode.date : 날짜
   - CupertinoDatePickerMode.time : 시간
   - CupertinoDatePickerMode.dateAndTime : 날짜와 시간
- Align 위젯은 자식 위젯을 어떻게 위치시킬지 정할 수 있다
- showCupertinoDialog 의 barrierDismissible 매개변수는 배경을 눌렀을 때의 행동을 지정
  - false : 배경을 눌러도 다이얼로그가 닫히지 않는다
  - ture : 배경을 눌렀을 때 다이얼로그가 닫힌다
- Alignment 의 정렬값
  - topRight : 위 오른쪽
  - topCenter : 위 중앙
  - topLeft : 위 왼쪽
  - centerRight : 중앙 오른쪽
  - center : 중앙
  - centerLeft : 중앙 왼쪽
  - bottomRight : 아래 오른쪽
  - bottomCenter : 아래 중앙
  - bottomLeft : 아래 왼쪽
  #### 10.4.4 CupertinoDatePicker 변경 값 상태 관리에 적용하기
  - CupertinoDatePicker 의 날짜 값이 변경될 때마다 firstDay 값을 변경해본다
  - onDateTimeChanged 의 콜백 함수는 CupertinoDatePicker 위젯에서 날짜가 변경될 때마다 실행
  - 콜백 함수가 실행될 때마다 매개변수로 제공되는 date 값을 firstDay 변수에 저장해준다
      
        
     
