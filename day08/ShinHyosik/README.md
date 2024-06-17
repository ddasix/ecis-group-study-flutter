# 디지털 주사위

## 사전지식

### 가속도계
- 특정 물체가 x, y, z축으로 이동하는 가속도의 값을 측정함
- x, y, z 축의 측정 결과가 `double`값으로 반환 됨

### 자이로스코프
- 특정 물체가 x, y, z축으로 회전하는 값을 측정함

### Sensor_Plus 패키지
- `sensor_plus`를 사용 하면 가속도, 자이로스코프 센서 값을 추출할 수 있음.
    ```dart
    import 'package:sensors_plus/sensors_plus.dart';
    ...
    // 중력을 반영한 가속도 값
    accelerometerEvents.listen((AccelerometerEvent event) {
        print(event.x);
        print(event.y);
        print(event.z);
    });

    // 중력을 반영하지 않은 순수 사용자의 힘에 의한 가속도 값
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
        print(event.x);
        print(event.y);
        print(event.z);
    });

    // 자이로스코프 센서 값
    gyroscopeEvent.listen((GyroscopeEvent event) {
        print(event.x);
        print(event.y);
        print(event.z);
    });
    ...
    ```
## 실습
