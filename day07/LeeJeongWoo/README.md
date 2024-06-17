# 단계 3 - 앱을 만들며 유용한 기능 익히기
## ch10 만난 지 며칠 U&I
### 10.1 사전 지식
10.1.1 setState() 함수
- state를 상속하는 모든 클래스는 setState() 함수를 사용할 수 있음

    `setState() 함수 실행 5 단계`  
    1. StatefulWidget의 렌더링이 끝나고 클린 상태
    2. setState()를 실행해서 원하는 속성들을 변경
    3. 속성이 변경되고 위젯의 상태가 더티로 설정
    4. bulid() 함수가 재실행
    5. State가 클린 상태로 다시 되돌아옴

    `setState() 함수 실행 방법`
    - 콜백 함수가 비동기로 작성되면 안 된다는 점에 주의   
    ```dart
    setState( {
      number ++;
    });
    ```
10.1.2 showCupertinoDialog() 함수
- iOS 스타일로 다이얼로그가 실행되며 실행 시 모든 애니메이션과 작동이 iOS 스타일로 적용
```dart
import 'package:flutter/cupertino.dart';    // Cupertino 패키지 임포트

showCupertinoDialog(    // Cupertino 다이얼로그 실행
  context: context,     // BuildContext 입력
  barrierDismissible: true, // 외부 탭해서 닫을 수 있게 하기
  builder: (BuildContext context) { // 다이얼로그에 들어갈 위젯
    return Text('Dialog');
  },
);
```
### 10.2 사전준비
10.2.1 이미지와 폰트 추가하기
- [asset/font], [asset/img] 경로를 생성하고 안에 파일 삽입

10.2.2 pubspec.yaml 설정하기
```dart
// pubspec.yaml

flutter:
  uses-material-design: true

  assets:
    - asset/img/

  fonts:
    - family: parisienne
      fonts:
        - asset: asset/font/Parisienne-Regular.ttf

    - family: sunflower
      fonts:
        - asset: asset/font/Sunflower-Light.ttf
        - asset: asset/font/Sunflower-Medium.ttf
          weight: 500
        - asset: asset/font/Sunflower-Bold.ttf
          weight: 700
```
10.2.3 프로젝트 초기화하기
- home_screen.dart 생성
- main.dart => HomeScreen 홈 위젯 등록

10.3 레이아웃 구상하기
- _DDay 위젯과 _CoupleImage위젯 두 가지를 위아래로 나누어서 구현
- 중앙의 하트를 클릭하면 CupertinoDialog 실행되는 구조로 구현

10.4 구현하기
- 순서
  - `1` UI 구현 -> `2 `상태 관리 구현 -> `3` 날짜 선택 기능 구현

10.4.1 홈 스크린 UI 구현하기
- _DDay 위젯처럼 이름 첫 글자가 언더스코어이면 다른 파일에서 접근할 수 없기 때문에 파일을 불러올 때 불필요한 값들이 한 번에 불러와지는걸 방지
- SafeArea를 적용하여 아이폰 노치 대비
- MainAxisAlignment.spaceBetween 을 사용하여 위아래 각각 끝에 _DDay와 _CoupleImage 위젯을 위치
- crossAxisAlignment.CrossAxisAlignment.strech 를 사용하여 반대축 최대 크기로 늘리기
- 이미지 삽입(중앙 정렬, 화면의 반만큼 높이 구현)
- 텍스트 위젯, 버튼 아이콘 삽입(스타일 및 테마지정)

`다양한 화면의 비율과 해상도에 따른 오버플로 해결하기`
- 이미지가 남는 공간만큼 차지하도록 Expanded 위젯을 사용

10.4.2 상태 관리 연습해보기
- StatefulWidget에서 setState() 함수를 사용해서 상태 관리 방법
    1. HomeScreen을 StatefulWidget으로 변경
    2. 상태 관리를 할 값인 '처음 만난 날'인 날짜를 firstDay 변숫값으로 선언  
    3. _DDay 생성자에 매개변수로 firstDay값을 입력해주고 fistDay 변수를 기반으로 날짜와 D-Day가 렌더링되게 함
    4. _DDay 위젯에서 사용할 DateTime값을 변수로 선언
    5. firstDay 변수의 값을 생성자의 매개변수로 외부에서 입력받도록 정의
    6. 현재 날짜시간 값을 now 변수에 저장
    7. DateTime을 년, 월, 일 형태로 변경
    8. 저장하고 핫리로드를 하면 오늘 날짜가 처음 만난 날로 정의되고 계산된 D-Day가 렌더링

10.4.3 CupertinoDatePicker로 날짜 선택 구현하기
- 하트 아이콘을 클릭하면 날짜를 선택할 수 있는 CupertinoDatePicker를 화면에 구현 
- showCupertinoDialog() 함수와 CupertinoDatePicker 위젯을 사용
- 외부를 탭했을 때 다이얼로그를 닫기 위한 barrierDismissible: true 값 설정
- 다이얼로그 화면 아래 크기 및 배치 설정변경

10.4.4 CupertinoDatePicker 변경 값 상태 관리에 적용하기
- setState() 함수를 이용한 상태관리와 CupertinoDatePicker를 연결
- CupertinoDatePicker의 날짜 값이 변경될 때마다 firstDay값 변경되도록 구현



