# 오늘도 출첵

## 사전지식

### `Geolocator` 플러그인

#### 위치 서비스 권한 확인하기

- 위치 서비스를 사용할 수 있는 상태 파악하기
    1. 기기의 위치서비스가 활성화 되어 있는지 확인.
        ```dart
        final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
        ```
    2. 앱에서 위치서비스 권한을 요청하고 허가받기.
        ```dart
        final checkedPermission = await Geolocator.checkPermission();
        final requestPermission = await Geolocator.requestPermission();
        ```

#### 현재 위치 지속적으로 반환하기
```dart
Geolocator.getPositionStream().listen((Position position) {
    print(position);
});
```

#### 두 위치간의 거리 구하기
```dart
// 두 위치간의 거리를 double값의 미터단위로 반환받음.
final distance = Geolocator.distanceBetween(sLat, sLng, eLat, eLng);    // 시작 위도, 시작 경도, 끝위도, 끝경도
```

## 실습

### 사전준비

1. 구글지도 API 키 발급
2. `pubspec.yml`에 `google_maps_flutter`, `geolocator` 추가 하고 다운로드
3. 네이티브 코드 설정
    - 안드로이드
        ```xml
            <!-- \/\/ android/app/src/main/AndroidManifest.xml -->
            ...
            <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

            <application ...>
                <meta-data android:name="com.google.android.geo.API_KEY" android:value="API_KEY">
            ...
        ```
    - IOS
        ```swift
            // ios/Runner/AppDelegate.swift

            ...
            import GoogleMaps;

            @UIApplicationMain
            @objc class AppDelegate: FlutterAppDelegate {
                override func application(
                    _ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
                ) -> Bool {
                    GMSServices.provideAPIKey("API KEY")
                    GeneratedPluginRegistrant.register(with: self)
                    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
                }
            }
            ...
        ```
        ```xml
            <!-- \/\/ ios/Runner/Info.plist -->
            ...
                <dict>
                    ...
                    <key>NSLocationWhenInUseUsageDescription</key>
                    <string>위치정보 필요</string>
                    <key>NSLocationAlwaysUsageDescription</key>
                    <string>위치정보 필요</string>
                </dict>
            ...
        ```
