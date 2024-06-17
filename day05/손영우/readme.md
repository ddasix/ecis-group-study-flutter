# Chapter 08. 블로그 웹 앱

##  사전지식
### 콜백함수
- 일정 작업이 완료되면 실행되는 함수
 ```dart
WebviewController controller = WebviewController();
..setNavigationDelegate(NavigationDelegate(
    onPageFinished: (String url) {
    print(url);
    }
))  
```
### 웹뷰 위젯
- 프레임워크에 내장된 브라우저를 앱에 포함.
- controller 파라미터에 WebViewController 객체를 입력.

## 사전준비
### pubspec.yaml 설정
- pubspec.yaml파일은 플러터 프로젝트와 관련된 설정을 하는 파일.
- 가져올 패키지를 기술하고 상단에 pub get 기능을 사용하여 적용.
### 권한 및 내이티브 설정
- androidmanifest.xml 파일에  android.permission.INTERNET 설정 및 usesCleartextTraffic 설정(http 사용)
- build.gradle 파일의 compileSdk 및 minSdkVersion 설정.
- ios는 runner/info.plist 에 NSAppTransportSecurity,NSAllowsLocalNetworking,NSAllowsArbitraryLoadsInWebContent 추가

## 구현하기
### 앱바
- 앱바, 웹뷰, 웹뷰 컨트롤, 홈버튼 순으로 구현
- lib에 HomeScreen.dart 추가 후 appbar 추가
```dart
class HomeScreen extends StatelessWidget{

const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text("실습"),
      centerTitle: true,
     ),
      body: Text("Home Screen"),
     );
  }
 
}
```
### 웹뷰
- WebviewController 를 추가하고 loadRequest로 이동할 사이트 지정
- setJavaScriptMode를 제한없이 설정.
```dart
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class HomeScreen extends StatelessWidget{


WebViewController webViewController = WebViewController()
..loadRequest(Uri.parse("https://naver.com"))
..setJavaScriptMode(JavaScriptMode.unrestricted);

HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text("실습"),
      centerTitle: true,
     ),
      body: WebViewWidget(
        controller:webViewController,
      ),
     );
  }
 
}
```
### main.dart
- WidgetsFlutterBinding.ensureInitialized() 프레임워크가 앱을 실행할 준비.
### 홈버튼 구현
- 앱바 우측끝에 아이콘 버튼 추가 및 동작 설정.
```dart
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class HomeScreen extends StatelessWidget{


WebViewController webViewController = WebViewController()
..loadRequest(Uri.parse("https://naver.com"))
..setJavaScriptMode(JavaScriptMode.unrestricted);

HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text("실습"),
      centerTitle: true,

actions: [
IconButton(onPressed: (){
  webViewController.loadRequest(Uri.parse("https://daum.net"));
}, icon: Icon(Icons.home,)) 
],
  ),
   body: WebViewWidget(
    controller:webViewController,
     ),
   );
  }
 
}
```
