# Chapter 05. 플로터 입문하기

## 플로터 소개
- 구글이 개발한 크로스플랫폼 프레임워크
- 임베더,엔진,프레임워크 3단계로 프레임워크가 구성.
- Enbedder : 플랫폼의 통신과 디바이스를 제어하는 계층.
- Engine  : C,C++로 만들어져 있는 Flutter 코어 API 계층.
- Framerowk : 개발자가 구현하는 기능들을 모아놓은 계층.

<img src="https://velog.velcdn.com/images/error/post/9e1f990d-33d9-4287-93b6-1aebd321f1cf/image.png" width="600px" height="400px" title="px(픽셀) 크기 설정" alt=""></img><br/>

## Hello Flutter 앱 만들기
### 안드로이드 스튜디오 기준
- dart 플러그인 설치.
- Flutter 플러그인 및 sdk 설치.
- 환경변수 설정.
- 프로젝트 생성 화면에서 new flutter project 선택.
- sdk 폴더 위치 설정.
- 프로젝트 정보 입력.

### VS 코드 기준
- dart 플러그인 설치.
- Flutter 플러그인 및 sdk 설치.
- 환경변수 설정.
- 프로젝트 생성 화면에서 Flutter:New Project 선택.
- Application 선택.
- 프로젝트를 저장할 폴더 선택 및 이름 설정.

### Hello World 출력
- 프로젝트를 생성하면 프로젝트 폴더/lib/main.dart 파일 생성.
- MaterialApp 위젯: 디자인 기반의 위젯 사용.
- Scaffold 위젯 : 화면 전체의 UI 담당 위젯.
- Text 위젯 : 텍스트 담당 위젯
- 플로터에서는 마지막 매개변수 끝에 ,를 붙임
```dart
void main() {
 runApp(
  const MaterialApp(
    home: Scaffold(
      body: Text(
        "hello world!",
        ),
    ),
  ),
 );
}
```
# Chapter 06. 기본위젯 알아보기
## 위젯소개
- 플로터 화면의 UI는 모두 위젯으로 구성.
- 자식을 하나만 갖는 위젯(child 매개변수),여러개 갖는 위젯(children 매개변수)로 구분
### child 매개변수 위젯
```dart
void main() {
 runApp(
  const MaterialApp(
    home: Scaffold(
      body: Center (
      child: Text("hello world!",),
    ),
  ),
 );
}
```
### children 매개변수 위젯
```dart
void main() {
 runApp(
  const MaterialApp(
    home: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [Text("test1"),Text("test2")],
        ),
      ), 
    ),
  ),
 );
}
```
## 텍스트 관련 위젯
- 화면에 글자를 보여주는 위젯.
- 폰트 속성을 지정 가능.
```dart
child: Text(
// 작성하고 싶은 글
'글자',
// 글자에 스타일 적용
style: TextStyle(
// 글자 크기
fontSize: 16.0,
// 글자 굵기
fontWeight: FontWeight.w700,
// 글자 색상
color: Colors.blue,
),
```
## 버튼 관련 위젯
- 사용자가 누를때 동작하는 버튼 위젯
```dart
  child: TextButton(
    // 클릭 시 실행
    onPressed: () {},
    // 스타일 지정
    style: TextButton.styleFrom(
      // 주 색상 지정
      foregroundColor: Colors.red,
    ),
    // 버튼에 넣을 위젯
    child: Text('텍스트 버튼'),
  ),
```
## 아이콘 버튼 관련 위젯
- 버튼 위젯에 보여주고 싶은 아이콘을 매개변수로 받는 위젯.
```dart
  child: IconButton(
    onPressed: () {},
    icon: Icon(
      Icons.home,
    ),
  ),
```
## 제스처 감지 위젯
- 사용자가 손으로 하는 입력을 감지하는 위젯
```dart
  child: GestureDetector(
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
## 플로팅 액션 버튼 위젯
-  Scaffold 영역에서 화면에 떠있는 버튼 위젯.
```dart
	home: Scaffold(
	floatingActionButton: FloatingActionButton(
	  // 클릭했을 때 실행할 함수
	  onPressed: () {},
	  child: Text('클릭'),
	),
	body: Container(),
	),
```
## 컨테이너 위젯
- 다른 위젯을 담을 수 있는 위젯.
```dart
  child: Container(
    // 스타일 작용
    decoration: BoxDecoration(
      // 배경 색깔 적용
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
  ),
```
## 사이즈박스 위젯
- 일정 크기의 공간을 공백으로 주는 위젯
```dart
  child: SizedBox(
    // 높이 지정
    height: 200.0,
    // 너비 지정
    width: 200.0,
    child: Container(
      color: Colors.red,
    ),
  ),
```
## 패딩 위젯
- child 위젯에 여백을 제공하는 위젯
```dart
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
```
## 로우 위젯
- 가로로 위젯을 배치하는데 사용되는 위젯.
- children 매개변수 사용
```dart
home: Scaffold(
body: SizedBox(
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
	width: 50.0,
	color: Colors.red,
      ),
      // SizedBox는 일반적으로 공백을
      // 생성할 때 사용
      const SizedBox(width: 12.0),
      Container(
	height: 50.0,
	width: 50.0,
	color: Colors.green,
      ),
      const SizedBox(width: 12.0),
      Container(
	height: 50.0,
	width: 50.0,
	color: Colors.blue,
      ),
    ],
  ),
),
```
## 컬럼 위젯
- 세로로 위젯을 배치하는데 사용되는 위젯.
- children 매개변수 사용.
```dart
  body: SizedBox(
  width: double.infinity,
  child: Column(
    // 주축 정렬 지정
    mainAxisAlignment: MainAxisAlignment.start,
    // 반대축 정렬 지정
    crossAxisAlignment: CrossAxisAlignment.start,
    // 넣고 싶은 위젯 입력
    children: [
      Container(
	height: 50.0,
	width: 50.0,
	color: Colors.red,
      ),
      // SizedBox는 일반적으로 공백을 생성할 때 사용
      const SizedBox(width: 12.0),
      Container(
	height: 50.0,
	width: 50.0,
	color: Colors.green,
      ),
      const SizedBox(width: 12.0),
      Container(
	height: 50.0,
	width: 50.0,
	color: Colors.blue,
      ),
    ],
  ),
),
```
## 플랙시블 위젯
- 로우 및 컬럼 위젯에서 child 크기를 최소한으로 설정할 수 있는 위젯.
```dart
  child: Column(
    children: [
      Flexible(
	// flex는 남은 공간을 차지할 비율을 의미합니다.
	// flex값을 값을 제공하지 않으면 기본값은 1입니다.
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
      )
    ],
  ),
```
## 익스팬디드 위젯
- 위젯이 지정한 영역을 모두 채우게 하는 위젯.  
```dart
 child: Column(
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
      )
    ],
  ),
```
## 스택 위젯
- 위젯 위에 위젯을 겹치게끔 하는 기능.
```dart
  child: Stack(
    children: [
      Container(
	height: 300.0,
	width: 300.0,
	color: Colors.red,
      ),
      Container(
	height: 250.0,
	width: 250.0,
	color: Colors.yellow,
      ),
      Container(
	height: 200.0,
	width: 200.0,
	color: Colors.blue,
      ),
    ],
  ),
```
