# 일정관리 앱

## 사전지식

### 파이어베이스

| 이름             | 기능                                                                    |
| ---------------- | ----------------------------------------------------------------------- |
| Authentication   | 소셜인증, 이메일인증, 휴대폰인증 등의 기능을 쉽게 연동                  |
| App Check        | 허가되지 않은 클라이언트가 API 요청을 막는 기능                         |
| Firestore        | NoSQL 데이터베이스, 실시간으로 클라이언트와 서버의 데이터 연동          |
| Realtime Databse | 파이어스토어와 비슷한 NoSQL 데이터베이스, 속도가 빠름                   |
| Storage          | 이미지, 오디오, 비디오등의 콘텐츠를 저장 할 수 있는 저장소              |
| Hosting          | 정적콘텐츠, 마이크로 서비스를 호스팅 함                                 |
| Functions        | 파이어베이스 또는 https 요청으로 서버코드를 실행 할 수 있음.            |
| Machine Learning | 텍스트인식, 이미지 라벨링, 물체감지 및 추적, 얼굴감지 등의 머신러닝기능 |
| Remote Config    | 앱을 새로 배포하지 않고 변경할 수 있는 설정값 기능 제공                 |
| Crashlytics      | 앱에 충돌이 있는경우 로그 분석용                                        |
| Performance      | 앱성능 모니터링                                                         |
| Test Lab         | 실제 프로덕션 기기를 사용해 앱을 테스트 할 수 있음                      |
| App Distribution | 앱 배포 기능 제공                                                       |
| Analytics        | 앱 트래픽과 사용자 활동등의 모니터링                                    |
| Messagig         | 푸시알람 기능 제공                                                      |

### 파이어스토어

- NoSQL 데이터베이스
- 파이어스토어의 데이터 개념
  1. collection: `table`에 해당 됨
  2. document: `table`의 `row`에 해당 됨
- `NoSQL`과 `관계형데이터베이스`의 비교

  1. NoSQL 데이터 구조
     ```json
     {
       "name": "코드팩토리",
       "age": 30,
       "favoriteFoods": ["치킨", "피자", "라면"]
     }
     ```
  2. 관계형데이터베이스
     - Person
       |name|age|
       |---|---|
       |코드팩토리|30|
     - Food
       |Person|name|
       |---|---|
       |코드팩토리|치킨|
       |코드팩토리|피자|
       |코드팩토리|라면|

- `insert`

  - `add()`를 사용

    - 데이터가 `insert` 될 때 자동으로 `id`를 생성 함.

      ```dart
      final data = {
          "name": "코드팩토리",
          "age": 30,
          "favoriteFoods": ["치킨", "피자", "라면"]
      };

      FirebaseFirestore.instance
        .collection('person')
        .add(data);
      ```

  - `set()`을 사용

    - 데이터의 `id`를 직접 지정할 수 있음.

      ```dart
      final data = {
          "name": "코드팩토리",
          "age": 30,
          "favoriteFoods": ["치킨", "피자", "라면"]
      };

      FirebaseFirestore.instance
        .collection('person')
        .doc(1)
        .set(data);
      ```

- `delete`
  ```dart
  FirebaseFirestore.instance
    .collection('person')
    .doc(1)
    .delete();
  ```
- `select`: `Stream`와 `Future` 방식으로 조회 할 수 있음
  - `Stream`: 데이터가 변경될때마다 실시간으로 조회 할 수 있음.
    ```dart
    FirebaseFirestore.instance
        .collection('person')
        .snapshots();
    FirebaseFirestore.instance
        .collection('person')
        .doc(1)
        .snapshots();
    ```
  - `Future`: 1회만 조회 됨
    ```dart
    FirebaseFirestore.instance
        .collection('person')
        .get();
    FirebaseFirestore.instance
        .collection('person')
        .doc(1)
        .get();
    ```
- `update`
  ```dart
  FirebaseFirestore.instance
    .collection('person')
    .doc(1)
    .update({
        'name': '골든래빗',
    });
  ```
## 실습
