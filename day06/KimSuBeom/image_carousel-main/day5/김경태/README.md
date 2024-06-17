# Dart 언어 마스터 하기
## 7. 앱을 만들려면 알아야 하는 그 밖의 지식
### 7.1 앱 만들기 프로세스
- 기획 -> 사전 지식 -> 사전 준비 -> 레이아웃 구상 -> 구현 -> 테스트
- 프로토타입용 프로그램
  - 피그마 : UI 디자인에 특화
  - 어도비 XD : 어도비에서 구현한 UI 디자인 툴
  - 플러터 플로우 : 플러터에 특화된 UI 구현 툴
- 폴더 구조
  - screen : 스크린 전체에 해당하는 위젯을 모아두는 폴더
  - component : 스크린을 구성하는데 공통으로 사용되는 요소의 위젯을 모아두는 폴더
  - model : 모델들을 따로 모아두는 폴더
  - const : 상수들을 모아두는 폴더 
### 7.2 플러그인 추가 방법
- pubspec.yaml 파일에 원하는 플러그인 추가
- [pub get] 버튼을 눌러서 등록한 플러그인을 프로젝트에서 사용
- WebView 플러그인을 추가하는 예
    ```dart
    dependencies:
        flutter:
            sdk: flutter

        cupertino_icons: ^1.0.6
        webview_flutter: 2.3.1
    ```
### 7.3 주변 장치 종류
- 플러터에서 지원하는 대표적인 주변 장치
  - 센서 : 핸드폰의 움직이는 속도를 측정하는 Accelerometer
  - GPS 
  - 카메라
  - 블루투스
  - 와이파이
### 7.4 연습용 앱 만들기 : 스플래시 스크린 앱
#### 7.4.1 사용자 정의 위젯 만들기 : 스테이트리스 위젯
- 위젯은 2가지 형태로 나뉜다.
  - 스테이트풀 위젯
    - 위젯 내부에서 값이 변경되었을 때 위젯 자체에서 다시 렌더링을 실행
  - 스테이트리스 위젯
    - 위젯 내부에서 값이 변경되어도 자체적으로 다시 렌더링 할 수 없음
    ```dart
    import 'package:flutter/material.dart';

    void main() {
    runApp(SplashScreen());
    }

    class SplashScreen extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
        }
    }
    ```
- runApp() 에 SplashScreen 위젯을 매개변수로 제공
- 앱 화면에 SplashScreen 의 build() 함수에 있는 코드의 실행 결과가 보인다.
#### 7.4.2 배경색 바꾸기 : Container 와 BoxDecoration 위젯
- Scaffold 위젯 바로 아래에 Container 위젯을 적용
    ```dart
    import 'package:flutter/material.dart';

    void main() {
    runApp(SplashScreen());
    }

    class SplashScreen extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
                home: Scaffold(
                    body: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                    ),
                    child: Center(
                        child: Text('Splash Screen'),
                    ),
                    ),
                ),
            );  
        }
    }
    ```
- Container 는 decoration 이라는 네임드 파라미터를 제공
- BoxDecoration 클래스를 사용하여 배경색, 테두리 색상, 테두리 두께 등 UI 를 지정
#### 7.4.3 이미지 출력하기 : Image 위젯
- Imgae 위젯 5가지 생성자
  - 기본 Image 생성자 : ImageProvider 위젯 위에 이미지를 그린다.
  - Image.asset 생성자 : 앱에 저장된 asset 파일로 이미지를 그린다.
  - Image.network 생성자 : URL 을 통해서 이미지를 그린다.
  - Image.file 생성자 : 파일을 통해서 이미지를 그린다.
  - Imgae.memory 생성자 : 메모리에서 직접 이미지를 그린다.
- 이미지를 담을 [asset] 폴더를 pubspec.yaml 파일에 지정.
    ```dart
    flutter:
    uses-material-design: true

    assets:
        - asset/img/
    ```
    ```dart
    child: Center(
        child: Image.asset(
            'assets/logo.png',
        ),
    ),
    ```
#### 7.4.4 위젯 정렬하기: Row & Column 위젯
- Center 위젯은 child 에 하나의 위젯만 가능
- Row 와 Column 위젯은 children 매개변수에 리스트로 원하는 만큼 위젯 추가 가능
- mainAxisAlignment: MainAxisAlignment.center 추가하여
  Image 위젯과 CircularProgressIndicator 위젯이 가운데 정렬
- width 에 200 픽셀을 입력해서 로고 너비 조정
- Row 위젯은 Column 위젯과 반대
  가로로는 최대 크기, 세로로는 최소 크기
- CircularProgressIndicator 의 valueColor 에 색상 지정
    ```dart
    import 'package:flutter/material.dart';

    void main() {
    runApp(SplashScreen());
    }

    class SplashScreen extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            home: Scaffold(
                body: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF99231),
                ),                
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Image.asset(
                            'assets/logo.png',
                            width: 200,
                        ),
                        CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                            Colors.white,
                            ),
                        ),
                        ],
                    ),
                    ],
                ),
                ),
            ),
            );
        }
    }
    ```
## 8. 블로그 웹 앱
### 8.1 사전 지식
#### 8.1.1 콜백 함수
- 콜백함수는 일정 작업이 완료되면 실행되는 함수
    ```dart
    WebviewController controller = WebviewController();
    ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) {
        print(url);
        }
    ))  
    ``` 
- onPageFinished() 는 웹뷰에서 페이지 로딩이 완료된 
#### 8.1.2 웹뷰 위젯
- 웹뷰는 프레임워크에 내장된 브라우저를 앱의 네이티브 컴포넌트에 임베딩하는 기능
- 앱에서 웹 브라우저 기능을 구현해주는 기술이다.
- 웹뷰 위젯의 속성
  - SetJavascriptMode : 웹뷰에서 자바스크립트 실행을 허용할지 여부를 결정
  - setBackgroundColor : 배경색을 지정
  - loadRequest : 새로운 URL 로 이동
  - setNavigationDelegate
    - onProgress : 새로운 페이지를 열어서 로딩이 될 때마다 실행
    - onPageStarted : 새로운 페이지로 이동하면 실행되는 콜백 함수
    - onPageFinished : 새로운 페이지로 이동이 완료되면 실행되는 콜백 함수
#### 8.1.3 안드로이드와 iOS 네이티브 설정
- 플러터 또한 결국 각 네이티브 플랫폼으로 코드가 컴파일되므로 최소한의 네이티브 설정은 필요
### 8.2 사전 준비
#### 8.2.1 pubspec.yaml 설정하기
- pubspec.yaml 파일은 플러터 프로젝트와 관련된 설정을 하는 파일
- webview_flutter 플러그인 추가
    ```dart
    dependencies:
    flutter:
    sdk: flutter

    webview_flutter: 4.4.1
    ```
    ```dart
    flutter pub get
    ```
- 주요 pub 명령어
  - flutter pub get : 플러그인을 내려받는다.
  - flutter pub add [플러그인 이름] : 플러그인 추가
  - flutter pub upgrade : 등록된 플러그인들을 모두 최신 버전으로 업데이트
  - flutter pub run : 현재 프로젝트를 실행
#### 8.2.2 권한 및 네이티브 설정하기
- 안드로이드
  - 인터넷 권한 (android/app/src/main/AndroidManifest.xml)
    ```dart
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.example.blog_web_app">
        <uses-permission android:name="android.permission.INTERNET" />
        ...
    </manifest>
    ```
  - 웹뷰 (android/app/build.gradle)
    ```dart
    android {
        compileSdkVersion 33
        ..

        defaultConfig {
            applicationId "com.example.blog_web_app"
            minSdkVersion 20
            ...
        }
    }
    ```
  - http 허용 (android/app/src/main/AndroidManifest.xml)
    ```dart
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.example.blog_web_app">
        <uses-permission android:name="android.permission.INTERNET" />
        <application 
            ...         
            android:usesCleartextTraffic="true">
            ...
        </application>
    </manifest>
    ```
- iOS
  - http 프로토콜 허용 (ios/Runner/Info.plist)
    ```dart
    <dict>
        <key>NSAppTransportSecurity</key>
            <dict>
            <key>NSAllowsLocalNetworking</key>
            <true/>
            <key>NSAllowsArbitraryLoadsInWebContent</key>
            <true/>
            </dict>
    </dict>
    ```
#### 8.2.3 프로젝트 초기화 하기
- 관련 .dart 파일 생성
### 8.3 레이아웃 구상하기
- 앱바와 웹뷰
### 8.4 구현하기
- lib/screen/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
 WebViewController webViewController = WebViewController()
   ..loadRequest(Uri.parse('https://blod.codefactory.ai'))
   ..setJavaScriptMode(JavaScriptMode.unrestricted);

 HomeScreen({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Code factory'),
       backgroundColor: Colors.orange,
       centerTitle: true,

       actions: [
         IconButton(
           onPressed: () {
             webViewController
                 .loadRequest(Uri.parse('https://blod.codefactory.ai'));
           },
           icon: Icon(Icons.home),
         )
       ],
     ),
     body: WebViewWidget(
       controller: webViewController,
     ),
   );
 }
}
```
- lib/main.dart
```dart
import 'package:blog_web_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```
