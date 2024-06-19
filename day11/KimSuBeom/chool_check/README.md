# 출첵
## 사전 지식
### Geolocator 플러그인
- 위치 서비스 사용 권한 확인 및 요청
    - isLocationServiceEnabled() 함수: 기기 위치서비스 기능 활성화 확인
    - checkPermission() : 권한 확인
    - requestPermission() : 권한 요청
        - LocationPermission enum 반환
```dart
final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
final checkedPermission = await Geolocator.checkPermission();
final checkedPermission = await Geolocator.requestPermission();
```
- 현 GPS 위치가 바뀔 때 현재 위칫값을 받을 수 있는 기능
    - 현재 위칫값을 Position 클래스 형태로 주기적으로 반환
```dart
Geolocator.getPositionStream().listen((Position position){
    print(position);
})
```
- 현 위치와 건물간의 거리 계산
    - 미터 단위로 반환
```dart
final distance = Geolocator.distanceBetween(
    sLat, //시작점 위도
    sLng, //시작점 경도
    eLat, //끝지점 위도
    eLng, //끝지점 경도    
);
```
## 사전 준비
### 구글 지도 API키 발급
### pubspec.yaml 설정
- google_maps_flutter : 지도 기능 제공
- geolocator : 위치 관련 기능 제공

### 네이티브 코드 설정
- ACCESS_FINE_LOCATION : 상세 위치 권한 의미
- 메타 태그에 구글 지도 API 키 입력

## 레이아웃 구상
- AppBar : 타이틀
- Body : 지도 및 마커
- Footer : 출근 버튼

## 구현
### 앱바 구현
- renderAppBar() 함수로 AppBar 위젯 정리

### Body 구현
- LatLng 클래스
    - 위도와 경도로 특정 위치를 표현할 수 있는 클래스
- GoogleMap 필수 매개변수 : initialCameraPosition
    - CameraPosition 클래스 입력
        - target 매개변수에 지도 중심이 될 위치를 LatLng 로 입력 가능
        - Zoom : 확대 정도, double 로 입력

### Footer 구현
- Column 위젯으로 2:1 비율로 구현

### 위치 권한 관리
- checkPermission() 함수 구현
    - String 반환
    - FutureBuilder로 UI 로직 구현

### 화면에 마커 그리기
