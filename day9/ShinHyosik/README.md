# 동영상 플레이어

## 사전지식

### 시간변환 및 String 패딩
1. `Duration`클래스 값을 그대로 표현하면 이해하기 어려움.
    ```dart
    Duration duration = Duration(seconds: 192);
    print(duration);    // 0:03:12.00000
    ```

2. `String`의 `split()`함수로 원하는 부분만 추출
    ```dart
    Duration duration = Duration(seconds: 192);
    print(duration.toString().split('.')[0]);    // 0:03:12
    ```

3. `분분:초초` 형태로 Duration 표현
    1. `sublist()`로 원하는 리스트만 추출 함
        ```dart
            Duration duration = Duration(seconds: 192);
            print(duration);    // 0:03:12.00000
            print(duration.toString().split('.')[0].split(':').sublist(1, 3).join(':'));    // 03:12
        ```
    2. `inMinutes`, `inSeconds` 이용
        ```dart
            Duration duration = Duration(seconds: 192);
            print(duration);    // 0:03:12.00000
            print('${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}');    // 03:12
        ```

4. `padLeft()`
    ```dart
        print('23'.padLeft(3, '0'));    // 023
        print('233'.padLeft(3, '0'));   // 233
    ```

## 실습

### 라이브러리
```yaml
...
dependencies:
    ...
    image_picker: 1.0.4 # 버전은 최신버전으로
    video_player: 2.8.1 # 버전은 최신버전으로
...
assets:
    - assets/images/    # 이미지 경로 추가
```

### 네이티브 설정
- IOS 권한추가(ios/Runner/Info.plist)
    ```xml
        ...
        <plist version="1.0">
        <dict>
            <!-- 코드생략 -->
            <key>NSPhotoLibraryUsageDescription</key>
            <string>갤러리 권한을 허가해주세요.</string>
        </dict>
        </plist>
    ```
- 안드로이드 권한추가(android/app/src/main/AndroidManifest.xml)
    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="...">
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
        <application ...>
            <!-- 코드생략 -->
        </application>
    </manifest>
    ```
