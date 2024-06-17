# 단계 2 - 플러터 기본다지기
## ch05 플러터 입문하기
### 5.1 플러터 소개
- 구글이 구현한 크로스 플랫폼 프레임워크<sup>cross platform framwork</sup>
- 플러터로 개발하면 한 소스 코드로 수많은 플랫폼에 대응할 수 있어서 개발 비용을 아끼고 관리 부담을 줄일 수 있음
- 상대적으로 다루기 쉽다는 점
- 크로스 플랫폼 호환성이 상당히 자연스러움
- 플랫폼 간의 이질감이 적음  

플러터 구조
- 플러터 3 계층
    - 프레임워크<sup>Framework</sup> 계층(하이 레벨) : 플러터 개발자들이 사용하는 계층
    - 엔진<sup>Engine</sup> : 대부분 C++로 작성되어있고 스키아 그래픽 엔진, 파일시스템, 네트워크 기능이 정의된 계층 
    - 임베더<sup>embedder</sup>(로우 레벨) : 플러터가 현재 지원하는 6개 네이티브 플랫폼과 직접 통신을 하고 자체적 기능을 모듈화해둔 계층
### 5.2 Hello Flutter 앱 만들기
- vscode에서 프로젝트를 생성할 경우  
    `CLI 방법으로 생성하기`  
    - 터미널을 실행하고 프로젝트를 생성하고자 하는 디렉토리로 이동 후 다음 명령어 입력  
    ```dart
    $ flutter create <DIRECTORY>

    예시 => $ flutter create hello_world
    ```
5.2.3 'Hello Code Factory' 출력하기
- 플러터 프로젝트를 생성하면 항상 같은 샘플 프로젝트가 <프로젝트 폴더>/lib 폴더 아래 main.dart 파일이 생성됨
    - 오른쪽 상단의 실행버튼을 눌러 실행하거나 터미널로 커맨더로 실행  

- 터미널 커맨더 명령어
    ```dart
    // 순수 Dart 스크립트 실행
    $ dart lib/main.dart
    
    // Flutter 앱 실행
    $ flutter run
    ```
## ch06 기본 위젯 알아보기
### 6.1 위젯 소개
- 플러터에서 화면에 보여지는 UI와 관련된 모든 요소는 위젯으로 구성되어 있음
- 위젯은 현재 주어진 상태<sup>state</sup>를 기반으로 어떤 UI를 구현할지를 정의
- 위젯의 상태가 변경되면 변경 사항에 알맞게 변경된 UI를 화면에 다시 그려줌
- UI 변화를 반영할 때 필요한 최소한의 리소스를 이용해서 UI 변경을 이끌어낼 수 있음

하나의 자식만 갖는 위젯(매개변수 child)
- Container 위젯
    - 자식을 담는 컨테이너 역할을 함
    - 배경색, 너비와 높이, 테두리 등의 디자인 지정 가능
- GestureDetector 위젯
    - 제스처 기능을 자식 위젯에서 인식하는 위젯
    - 탭이나 드레그 그리고 더블 클릭 같은 제스처 기능이 자식 위젯에 인식됐을 때 함수를 실행할 수 있음
- SizedBox 위젯
    - 높이와 너비를 지정하는 위젯
    - Container 위젯과 다르게 디자인적 요소는 적용할 수 없음
    - const 생성자로 선언할 수 있어서 퍼포먼스 측면에서 더 효율적

다수의 자식을 입력할 수 있는 위젯(매개변수 children)
- Column 위젯
    - children 매개변수에 입력된 모든 위젯들을 세로로 배치
- Row 위젯
    - children 매개변수에 입력된 모든 위젯들을 가로로 배치
- ListView 위젯
    - 리스트를 구현할 때 사용
    - children 매개변수에 다수의 위젯을 입력할 수 있음
    - 입력된 위젯이 화면을 벗어나게 되면 스크롤 가능

6.1.1 Children와 Child의 차이점
- 플러터는 위젯 아래에 계속 위젯이 입력되는 형태로 `위젯 트리`를 구성하여 UI를 제작
- child 매개변수와 children 매개변수는 위젯에 하위 위젯을 추가할 때 사용
- child는 위젯을 하나만 추가할 수 있음
- children은 여럿을 추가할 수 있음
- 부분 위젯은 child 또는 children 매개변수를 하나만 제공
- child와 children 매개변수를 동시에 입력받는 위젯은 존재 X
```dart
// child 매개변수에는 단하나의 위젯만 입력할 수 있음
import 'package:flutter/material.dart';

void main() {
    runApp(
        MaterialApp(
            home: Scaffold(
                body: Center(

                    // 하나의 위젯만 가운데 정렬 가능
                    child: Text('Code Factory'),
                ),
            ),
        ),
    );
}
```

```dart
// children 매개변수에는 여러 위젯을 리스트에 입력할 수 있음
import 'package:flutter/material.dart';

void main() {
    runApp(
        MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: SizedBox(
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAligment.center,

                        // 여러 위젯을 Column 위젯에 입력 가능
                        children: [
                            Text('Code'),
                            Text('Factory'),
                        ],    
                    ),
                ),
            ),
        ),
    );
}
```
6.2 위젯 실습용 템플릿 작성
```dart
    import 'package:flutter/material.dart';

    void main() {
        runApp(MyApp());
    }   

    class MyApp extends StatelessWidget {
        @override
        Widget build(BuildContext context){            
            return MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: // 여기에 예제 코드 작성
                    ),
                ),
            );            
        }
    }
```
### 6.3 텍스트 관련 위젯
- 화면에 글자를 보여주려면 글자를 렌더링할 수 있는 위젯을 사용해야함
- 첫 번째 포지셔널 파라미터에 원하는 문자열을 작성
- Style이라는 네임드 파리미터를 사용해 스타일을 지정
```dart
Text(
    // 작성하고 싶은 글
    'hello everyone~!',
    // 글자에 스타일 적용
    style: TextStyle(
        // 글자 크기
        fontSize: 16.0,
        // 글자 굵기
        fontWeight: FontWeight.w700,
        // 글자 색상
        color: Colors.blue,
    ),
)   
```
### 6.4 제스처 관련 위젯
- 플러터 머터리얼 패키지에서 기본 제공하는 버튼

6.4.1. Button 위젯
```dart
# TextButton(텍스트만 있는 버튼)

TextButton(
    // 클릭 시 실행        
    onPressed: () {},
    // 스타일 지정      
    style: TextButton.styleFrom(
        // 주색상 지정            
        foregroundColor: Colors.red,
    ),
    // 버튼에 넣을 위젯        
    child: Text('텍스트 버튼'),
),  
```
```dart
# OutlinedButton(테두리가 있는 버튼)

OutlinedButton(       
    // 클릭 시 실행할 함수
    onPressed: () {},
    // 버튼 스타일
    style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
    ),
    // 버튼에 들어갈 위젯
    child: Text('아웃라인드 버튼'),
),  
```
```dart
# ElevatedButton(입체적으로 튀어나온 느낌의 배경이 들어간 버튼)

ElevatedButton(
    // 클릭 시 실행할 함수
    onPressed: (){},
    // 버튼 스타일링
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
    ),
    // 버튼에 들어갈 위젯
    child: Text('엘레베이티드 버튼'),
),  
```
6.4.2 IconButton 위젯
- 아이콘을 버튼으로 생성하는 위젯
- onPressed 매개변수에 IconButton을 누르면 실행할 콜백 함수를 제공할 수 있음
- 플러터에서 기본으로 제공하는 아이콘(https://fonts.google.com/icons)
```dart
IconButton(
    onPressed: () {},
    icon: Icon(
        Icons.home,
    ), 
), 
```
6.4.3 GestureDetector 위젯
- 손가락으로 하는 여러 가지 입력을 인지하는 위젯
```dart
GestureDetector(
    // 한 번 탭했을 때 실행할 함수
    onTap: (){
        print('on tap');
    },
    // 두 번 탭했을 때 실행할 함수
    onDoubleTap: ( ){
        print('on double tap');
    },
    // 길게 눌렀을 때 실행할 함수
    onLongPress: (){
        print('on long press');
    },
    // Gesture를 적용할 위젯
    child: Container(
        decoration: BoxDecoration(
        color: Colors.red,
        ),
        width: 100.0,
        height: 100.0,
    ),
),
```
GestureDetector 중요 제스처  
- `onTap` : 한 번 탭 했을 때 실행 함수를 입력할 수 있음
- `onDoubleTap` : 두 번 연속으로 탭 했을 때 실행 함수를 입력할 수 있음
- `onLongPress` : 길게 누르기가 인식됐을 때 실행 함수를 입력할 수 있음
- `onPanStart` : 수평 또는 수직 드래그가 시작됐을 때  실행 함수를 입력할 수 있음
- `onPanUpdate` : 수평 또는 수직 드래그 하는 동안 드래그 위치가 업데이트 될 때마다 실행 함수를 입력할 수 있음
- `onPanEnd` : 수평 또는 수직 드래그가 끝났을 때 실행 함수를 입력할 수 있음
- `onHorizontalDragStart` : 수평 드래그가 시작했을 때 실행 함수를 입력할 수 있음
- `onHorizontalDragUpdate` : 수평 드래그 하는 동안 드래그 위치가 업데이트 될 때마다 실행 함수를 입력할 수 있음
- `onHorizontalDragEnd` : 수평 드래그가 끝났을 때 실행 함수를 입력할 수 있음
- `onVerticalDragStart` : 수직 드래그가 시작했을 때 실행 함수를 입력할 수 있음
- `onVerticalDragUpdate` : 수직 드래그 하는 동안 드래그 위치가 업데이트 될 때마다 실행 함수를 입력할 수 있음
- `onVerticalDragEnd` : 수직 드래그가 끝났을 때 실행 함수를 입력할 수 있음
- `onScaleStart` : 확대가 시작 됐을 때 실행 함수를 입력할 수 있음
- `onScaleUpdate` : 확대가 진행되는 동안 확대가 업데이트 될 때마다 실행 함수를 입력할 수 있음
- `onScaleEnd` : 확대가 끝났을 때 실행 함수를 입력할 수 있음

6.4.4 FloatingActionButton 위젯
- FloatingActionButton은 Material Design에서 추구하는 버튼 형태
```dart
import 'pakage:flutter/material.dart';

void main() {
    runApp(FloatingActionButtonExample());
}

class FloatingActionButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          // 클릭했을 때 실행할 함수
          onPressed: () {},
          child: Text('클릭'),
        ),
        body: Container(),
      ),
    );
  }
}
```
## 6.5 디자인 관련 위젯
6.5.1 Container 위젯
- 다른 위젯을 담는 데 사용
- 너비와 높이를 지정하거나 배경이나 테두리를 추가할 때 많이 사용됨
- 다른 위젯처럼 child 매개변수 사용 가능
```dart
Container(
  // 스타일 적용
  decoration: BoxDecoration(
    // 배경색 적용
    color: Colors.red,
    // 테두리 적용
    border: Border.all(
        // 테두리 굵기
        width: 16.0,
        // 테두리 색상
        color: Colors.black,
    ),
    // 모서리 둥글게 만들기
    borderRadius: BorderRadius.circular(
    16.0,
    ),
  ),
  // 높이
  height: 200.0,
  // 너비
  width: 100.0,
)
```
6.5.2 SizedBox 위젯
- 일정 크기의 공간을 공백으로 두고 싶을 때 사용
```dart
SizedBox(
    // 높이 지정     
    height: 200.0,

    // 너비 지정        
    width: 200.0,

    // SizedBox는 색상이 없으므로 크기를 확인하는 용도로 Container 추가
    child: Container(
        color: Colors.red,
    ),
),
```
6.5.3 Padding 위젯
- child 위젯에 여백을 제공할 때 사용
```dart
Container(
  color: Colors.blue,
  child: Padding(

    // 상하, 좌우로 모두 16픽셀만큼 패딩을 적용
    padding: EdgeInsets.all(
      16.0,
    ),
    child: Container(
      color: Colors.red,
      width: 50.0,
      height: 50.0,
    ),
  ),
)    
```
- 위젯의 바깥에 간격을 추가해주는 마진<sup>margin</sup> 기능
    - 따로 위젯이 존재하지 않고 Container 위젯에 추가하여 사용
```dart
// 최상위 검정 컨테이너
Container(
    color: Colors.black,

    // 중간 파란 컨테이너
    child: Container(
        color: Colors.blue,

        // 마진 적용 위치
        margin: EdgeInsets.all(16,0),

        // 패딩 적용
        child: Padding(
            padding: EdgeInsets.all(16,0),
        
            // 패딩이 적용된 빨간 컨테이너
            child: Container(
                color: Colors.red,
                width: 50,
                height: 50,
            ),
        ),
    ),
),
```
`EdgeInsets` 클래스
- `EdgeInsets.all(16,0)`
    - 상하좌우로 매개변수에 입력된 패딩을 균등하게 적용
- `EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)`
    - 가로와 세로 패딩을 따로 적용
    - Horizontal 매개변수에 가로로 적용할 패딩을 입력
    - Vertical 매개변수에 세로로 적용할 패딩을 입력
- `EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0)`
    - 위아래, 좌우 패딩을 따로 적용
    - top, bottom, left, right 매개변수에 각각 위아래, 좌우 패딩을 입력할 수 있음
- `EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0)`
    - 위아래, 좌우 패딩을 따로 적용
    - 포지셔널 파라미터를 좌, 위, 우, 아래 순서로 입력해줘야 함  

6.5.4 SafeArea
- 따로 기기별로 예외 처리를 하지 않고도 안전한(Safe)화면에서만 위젯을 그릴 수 있음
```dart
SafeArea(
    // 원하는 부위만 따로 적용할 수도 있음
    // true는 적용 false는 미적용
    top: true,
    bottom: true,
    left: true,
    right: true,
    child: Container(
        color: Colors.red,
        height: 300.0,
        width: 300.0,
    ),
),
```
## 6.6 배치 관련 위젯
- 하위 위젯을 가로 또는 세로로 배치하거나 위젯 위에 위젯을 겹칠 때 사용
6.6.1 Row 위젯
- Column과 함께 위젯을 가로세로로 배치하는 데 사용됨
```dart
import 'package:flutter/material.dart';

void main() {
    runApp(RowWidgetExample());
}

class RowWidgetExample extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home : Scaffold(
                body : SizedBox(

                    // 반대축에서 이동할 공간을 제공하기 위해 높이를 최대한으로 설정
                    height: double.infinity,
                    child: Row(

                        // 주축 정렬 지정
                        mainAxisAlignment: MainAxisAlignment.start,
                        // 반대축 정렬 지정
                        crossAxisAlignment: CrossAxisAlignment.center,

                        // 넣고 싶은 위젯 입력
                        children: [
                            Container(
                                height: 50.0,
                                width:50.0,
                                color: Colors.red,
                            ),

                            // SizedBox는 일반적으로 공백을 생성할 때 사용
                            const SizedBox(width: 12.0),
                            Container(
                                height: 50.0,
                                width:50.0,
                                color: Colors.green,
                            ),
                            const SizedBox(width: 12.0),
                            Container(
                                height: 50.0,
                                width:50.0,
                                color: Colors.blue,
                            ),
                        ]
                    )
                )
            )
        )
    }
}
```
`MainAxisAlignment` 표
  - `MainAxisAlignment.start` : 시작에 정렬
  - `MainAxisAlignment.center` : 시작에 정렬
  - `MainAxisAlignment.end` : 끝에 정렬
  - `MainAxisAlignment.spaceBetween` : 자식 위젯의 간격을 균등하게 정렬
  - `MainAxisAlignment.spaceAround` : 자식 위젯의 간격을 균등하게 배정하고 왼쪽 끝과 오른쪽 끝을 위젯 사이거리의 반만큼 배정해 정렬
  - `MainAxisAlignment.spaceEvenly` : 자식 위젯의 간격을 균등하게 배치하고 왼쪽 끝과 오른쪽 끝도 균등하게 배치

  `CrossAxisAlignment` 표
  - `CrossAxisAlignment.start` : 시작에 정렬
  - `CrossAxisAlignment.center` : 시작에 정렬
  - `CrossAxisAlignment.end` : 끝에 정렬
  - `CrossAxisAlignment.stretch` : 반대축 최대한으로 늘려서 정렬

6.6.2 Column 위젯
- Row 위젯과 완전히 같은 매개변수들을 노출함
- 주축과 반대축이 Row와 반대로 이루어져 있음
```dart
import 'package: flutter/material.dart';
void main() {
    runApp(ColumnWidgetExample());
}
class ColumnWidgetExample extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                body: SizedBox(
                    // 반대축에서 이동할 공간을 제공해주기 위해 너비를 최대한으로 설정
                    width: double.infinity,
                    child: Column(

                    // 주축 정렬 지정
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    // 반대축 정렬 지정
                    crossAxisAlignment: CrossAxisAlignment.center,

                    // 넣고 싶은 위젯 입력
                    children: [
                        Container(
                            height: 50.0,
                            width:50.0,
                            color: Colors.red,
                        ),
                        // SizedBox는 일반적으로 공백을 생성할 때 사용
                        const SizedBox(width: 12.0),
                        Container(
                            height: 50.0,
                            width:50.0,
                            color: Colors.green,
                        ),
                        const SizedBox(width: 12.0),
                        Container(
                            height: 50.0,
                            width:50.0,
                            color: Colors.blue,
                        ),
                      ],        
                    )
                )
            )
        )
    }
}
```
`MainAxisAlignment` 표
  - `MainAxisAlignment.start` : 시작에 정렬
  - `MainAxisAlignment.center` : 시작에 정렬
  - `MainAxisAlignment.end` : 끝에 정렬
  - `MainAxisAlignment.spaceBetween` : 자식 위젯의 간격을 균등하게 정렬
  - `MainAxisAlignment.spaceAround` : 자식 위젯의 간격을 균등하게 배정하고 왼쪽 끝과 오른쪽 끝을 위젯 사이 거리의 반만큼 배정해 정렬
  - `MainAxisAlignment.spaceEvenly` : 자식 위젯의 간격을 균등하게 배치하고 왼쪽 끝과 오른쪽 끝도 균등하게 배치

`CrossAxisAlignment` 표
  - `MainAxisAlignment.start` : 시작에 정렬
  - `MainAxisAlignment.center` : 시작에 정렬
  - `MainAxisAlignment.end` : 끝에 정렬
  - `MainAxisAlignment.stretch` : 반대축 최대한으로 늘려서 정렬

6.6.3 Flexible 위젯
- Row나 Column에서 사용하는 위젯
- Flexible에 제공된 child가 크기를 최소한으로 차지하게 할 수 있음
- 추가적으로 flex 매개변수를 이용해 각 Flexible 위젯이 얼만큼의 비율로 공간을 차지할지 지정할 수도 있음
```dart
Column(
  children: [
        Flexible(
        // flex는 남은 공간을 차지할 비율을 의미함
        // flex값을 제공하지 않으면 기본값은 1
        flex: 1,

        // 파란색 Container
        child: Container(
            color: Colors.blue,
        ),
      ),
      Flexible(
        flex: 1,

        // 빨간색 Container
        child: Container(
            color: Colors.red,
        ),
      ),
  ],
),  
```
6.6.4 Expanded 위젯
- Flexible 위젯을 상속하는 위젯
- Column과 Row에서 Expanded를 사용하면 위젯이 남아 있는 공간을 최대한으로 차지함
- fit 매개변수에 FlexFit.tight 또는 FlexFit.loose를 입력할 수 있으나 부모인 Flexible 위젯의 fit 매개변수에 FlexFit.tight를 기본값으로 제공하므로 Flexible 위젯과 다르게 남는 공간을 최대한으로 차지함
```dart
Column(
    children: [
        // 파란색 Container
        Expanded(
            child: Container(
                color: Colors.blue,
            ),
        ),

        // 빨간색 Container
        Expanded(
            child: Container(
                color: Colors.red,
            ),
        ),
    ],
),
```
6.6.5 Stack 위젯
- 위젯을 겹치는 기능을 제공
- 스키아 엔진은 2D이기 때문에 겹친 두께를 표현할 순 없지만 Stack을 사용하면 위젯 위에 위젯을 올린 듯한 효과를 줄 수 있음
- children에 위차한 순서대로 위젯을 겹침
```dart
Stack(
    children: [
        // 빨간색 Container
        Container(
            height: 300.0,
            width: 300.0,
            color: Colors.red,
        ),

        // 노란색 Container
        Container(
            height: 250.0,
            width: 250.0,
            color: Colors.yellow,
        ),

        // 파란색 Container
        Container(
            height: 200.0,
            width: 200.0,
            color: Colors.blue,
        ),
    ],
),
```
