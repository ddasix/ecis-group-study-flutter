# Dart 언어 마스터 하기
## 5. 플러터 입문하기
### 5.1 플러터 소개
- 구글이 구현한 크로스 플랫폼 프레임워크
- 웹사이트, macOS, 윈도우, 리눅스 까지 지원
- 스키아 엔진이 실행되는 플랫폼에서는 똑같은 API 를 사용해서 프로그래밍 가능
- 플러터 프레임워크는 세 계층으로 나눠져 있다.
  - Framework (dart)
  - Engine (c/c++)
  - Embedder (platform-specific)
### 5.2 Hello Flutter 앱 만들기
#### 5.2.1 안드로이드 스튜디오에서 프로젝트 생성하기
- GUI 환경에서 생성하기
  - [New Flutter Project]
  - [Flutter] -> [Flutter SDK Path]
  - 프로젝트 이름 지정, 안드로이는 Kotlin, iOS 는 Swift
  - finish
- CLI 환경에서 프로젝트 생성하기
  - terminal) flutter create 프로젝트 이름
#### 5.2.2 가상 머신 테스트 환경 안내
- 프로젝트를 실행할 수 있는 안드로이드 에뮬레이터를 생성해야 한다.
  - 안드로이드 에뮬레이터 생성하기
  - iOS 시뮬레이터 실행하기
#### 5.2.3 'Hello Code Factory' 출력하기
- <프로젝트 폴더>/lib 폴더 아래 main.dart 파일 생성
- main() 함수는 플러터 프로젝트가 실행되는 도입부.
- MaterialApp 은 Material 디자인 기반의 위젯들을 사용하게 해주는 위젯.
- Scaffold는 Materal 다음에 위치하는 위젯, 레이아웃을 도와주고 UI 관련 특수 기능을 제공.
    ```dart
    import 'package:flutter/material.dart';

    void main() {
        runApp(
            const MaterialApp(
            home: Scaffold(
                body: Text(
                'Hello world!',
                ),
            ),
            ),
        );
    }
    ```
#### 5.2.4 Center 위젯으로 중앙 정렬
- 글자가 잘 보이게 화면의 가운데로 옮기기 위해 `Center` 위젯 사용
    ```dart
    import 'package:flutter/material.dart';

    void main() {
        runApp(
            const MaterialApp(
            home: Scaffold(
                body: Center(
                    child: Text(
                        'Hello world!',
                    )                
                ),
            ),
            ),
        );
    }
    ```
### 5.3 실제 단말 테스트 환경 구축
#### 5.3.1 안드로이드 실제 기기 사용하기
#### 5.3.2 아이폰 실제 기기 사용하기
## 6. 기본 위젯 알아보기
### 6.1 위젯 소개
- 플러터는 화면에 그려지는 모든 요소가 위젯.
- 위젯은 현재 주어진 상태를 기반으로 어떤 UI 를 구현할지를 정의
- 자식을 하나만 갖는 위젯
  - `Container` : 자식을 담는 컨테이너. 배경색,너비와 높이, 테두리
  - `GestureDetector` : 제스처 기능을 자식 위젯에서 인식하는 위젯
  - `SizedBox` : 높이와 너비를 지정하는 위젯
- 다수의 자식을 갖는 위젯
  - `Column` : 위젯들을 세로로 배치
  - `Row` : 위젯들을 가로로 배치
  - `ListView` : 리스트를 구현할 때 사용
#### 6.1.1 Children 와 Child 의 차이점
- child 와 children 은 위젯에 하위 위젯을 추가할 때 사용
- child 는 위젯을 하나만 추가 가능
- children 은 여럿을 추가 가능
- child 와 children 을 동시에 입력받는 위젯을 없음
### 6.2 위젯 실습용 템플릿 작성
-
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
                        child:
                    ),
                ),
            );            
        }
    }
    ```
### 6.3 텍스트 관련 위젯
- 글자를 렌더링 할 수 있는 위젯
    ```dart
    Text(
        'hello world',
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
        ),
    )   
    ```  
### 6.4 제스처 관련 위젯 
#### 6.4.1 Button 위젯
- TextButton
    ```dart
    TextButton(        
        onPressed: () {},        
        style: TextButton.styleFrom(            
            foregroundColor: Colors.red,
        ),        
        child: Text('텍스트 버튼'),
    ),  
    ```   
- OutlineButton
    ```dart
    OutlinedButton(       
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
        ),
        child: Text('아웃라인드 버튼'),
    ),  
    ```  
- ElevateButton
    ```dart
    ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
        ),
        child: Text('엘레베이티드 버튼'),
    ),  
    ``` 
#### 6.4.2 IconButton 위젯
- 아이콘을 버튼으로 생성하는 위젯
- onPressed 매개변수에 IconButton 을 누르면 실행할 콜백 함수를 제공
    ```dart
    IconButton(
        onPressed: () {},
        icon: Icon(
            Icons.home,
        ), 
    ), 
    ```
#### 6.4.3 GestureDetector 위젯
- 손가락으로 하는 여러 가지 입력을 처리
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
- `onTap` : 한 번 탭 했을 때
- `onDoubleTap` : 두 번 연속으로 탭 했을 때
- `onLongPress` : 길게 누르기
- `onPanStart` : 수평 또는 수직 드래그
- `onPanUpdate` : 수평 또는 수직 드래그 하는 동안 드래그 위치가 업데이트 될 때
- `onPanEnd` : 수평 또는 수직 드래그가 끝났을 때
- `onHorizontalDragStart` : 수평 드래그가 시작했을 때
- `onHorizontalDragUpdate` : 수평 드래그 하는 동안 드래그 위치가 업데이트 될 때
- `onHorizontalDragEnd` : 수평 드래그가 끝났을 때
- `onVerticalDragStart` : 수직 드래그가 시작했을 때
- `onVerticalDragUpdate` : 수직 드래그 하는 동안 드래그 위치가 업데이트 될 때
- `onVerticalDragEnd` : 수직 드래그가 끝났을 때
- `onScaleStart` : 확대가 시작 됐을 때
- `onScaleUpdate` : 확대가 진행되는 동안 확대가 업데이트 될 때
- `onScaleEnd` : 확대가 끝났을 때
#### 6.4.4 FloatingActionButton 위젯
- 플로팅 작업 버튼
    ```dart
    Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text(
            '클릭',
            ),
        ),
        body: Container(),
    ),
    ```
### 6.5 디자인 관련 위젯
#### 6.5.1 Container 위젯
- 다른 위젯을 담는데 사용. 위젯의 너비와 높이, 배경, 테두리를 추가할 때 많이 사용.
    ```dart
    Container(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
            width: 16.0,
            color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(
            16.0,
            ),
        ),
        height: 200.0,
        width: 100.0,
    ),
    ```
#### 6.5.2 SizedBox 위젯
- 일정 크기의 공간을 공백으로 두고 싶을 때 사용.
    ```dart
    SizedBox(        
        height: 200.0,        
        width: 200.0,
        child: Container(
            color: Colors.red,
        ),
    ),
    ```
#### 6.5.3 Padding 위젯
- child 위젯에 여백을 제공할 때 사용.
    ```dart
    Scaffold(
        body: Center(
          child: Container(
            color: Colors.blue,
            child: Padding(

              // 상하, 좌우로 모두 16픽셀만큼 패딩을 적용합니다.
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Container(
                color: Colors.red,
                width: 50.0,
                height: 50.0,
              ),
            ),
          ),
        ),
    ),
    ```
#### 6.5.4 SafeArea
- 기기별로 예외 처리를 하지 않고도 안전한 화면에서만 위젯을 그림
    ```dart
    SafeArea(
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
### 6.6 배치 관련 위젯
#### 6.6.1 Row 위젯
- 가로로 위젯을 배치할 때 사용
    ```dart
    SizedBox(
        // 반대축 (세로)에서 이동할 공간을 제공해주기 위해 높이를 최대한으로 설정
        height: double.infinity,
        child: Row(
            // 주축 정렬 지정
            mainAxisAlignment: MainAxisAlignment.start,
            // 반대축 정렬 지정
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
    ),      
    ```
- `MainAxisAlignment`
  - `start` : 시작에 정렬
  - `center` : 시작에 정렬
  - `end` : 끝에 정렬
  - `spaceBetween` : 자식 위젯의 간격을 균등하게 정렬
  - `spaceAround` : 왼쪽 끝과 오른쪽 끝을 위젯 사이 거리의 반만큼 배정해 정렬
  - `spaceEvenly` : 왼쪽 끝과 오른쪽 끝도 균등하게 정렬
- `CrossAxisAlignment`
  - `start` : 시작에 정렬
  - `center` : 시작에 정렬
  - `end` : 끝에 정렬
  - `stretch` : 반대축 최대한으로 늘려서 정렬
#### 6.6.2 Column 위젯
- 세로로 위젯을 배치할 때 사용
    ```dart
    SizedBox(
        // 반대축 (가로)에서 이동할 공간을 제공해주기 위해 너비를 최대한으로 설정
        width: double.infinity,
        child: Column(
            // 주축 정렬 지정
            mainAxisAlignment: MainAxisAlignment.start,
            // 반대축 정렬 지정
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
    ),    
    ```
- `MainAxisAlignment`
  - `start` : 시작에 정렬
  - `center` : 시작에 정렬
  - `end` : 끝에 정렬
  - `spaceBetween` : 자식 위젯의 간격을 균등하게 정렬
  - `spaceAround` : 왼쪽 끝과 오른쪽 끝을 위젯 사이 거리의 반만큼 배정해 정렬
  - `spaceEvenly` : 왼쪽 끝과 오른쪽 끝도 균등하게 정렬
- `CrossAxisAlignment`
  - `start` : 시작에 정렬
  - `center` : 시작에 정렬
  - `end` : 끝에 정렬
  - `stretch` : 반대축 최대한으로 늘려서 정렬
#### 6.6.3 Flexible 위젯
- Row 나 Column 에서 사용하는 위젯
- Flexible 에 제공된 child 가 크기를 최소한으로 차지하게 할 수 있다.
    ```dart
    Column(
        children: [
            Flexible(
            flex: 3,
            child: Container(
                color: Colors.blue,
            ),
            ),
            Flexible(
            flex: 1,
            child: Container(
                color: Colors.red,
            ),
            ),
        ],
    ),  
    ```
#### 6.6.4 Expanded 위젯
- Flexible 위젯을 상속하는 위젯
- Column 과 Row 에서 Expanded 를 사용하면 위젯이 남아있는 공간을 최대한으로 차지
- 부모인 Flexible 위젯의 fit 매개변수에 FlexFit.tight 가 디폴트로 지정
    ```dart
    Column(
        children: [
            Expanded(
            child: Container(
                color: Colors.blue,
            ),
            ),
            Expanded(
            child: Container(
                color: Colors.red,
            ),
            ),
        ],
    ),
    ```
#### 6.6.5 Stack 위젯
- 위젯을 겹치는 기능을 제공
- 스키아 엔진은 2D 엔진으로 겹친 두께를 표현 못하지만 위젯 위에 위젯을 올린 듯한 효과를 준다.
- 부모인 Flexible 위젯의 fit 매개변수에 FlexFit.tight 가 디폴트로 지정
    ```dart
    Stack(
        children: [
            Container(
            height: 300.0,
            width: 300.0,
            color: Colors.blue,
            ),
            Container(
            height: 250.0,
            width: 250.0,
            color: Colors.red,
            ),
            Container(
            height: 200.0,
            width: 200.0,
            color: Colors.green,
            ),
        ],
    ),
    ```