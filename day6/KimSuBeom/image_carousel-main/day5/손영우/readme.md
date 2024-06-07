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
- androidmanifest.xml 파일에  android.permission.INTERNET 설정.
- build.gradle 파일의 compileSdk 및 minSdkVersion 설정.

