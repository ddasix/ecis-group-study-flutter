# 앱을 만들며 유용한 기능 익히기
## 18. 데이터베이스 적용하기 
- 17장에서 작업한 앱에 로컬 데이터베이스 기능을 추가한다
### 18.1 사전지식
- SQL 의 구조
  - CREATE TABLE
  - INSERT INTO
  - SELECT
  - UPDATE
  - DELETE
#### 18.1.2 드리프트 플러그인
- 드리프트 플러그인을 사용하면 SQL 을 작성하지 않도고 SQLite 를 사용할 수 있다
- 객체-관계 모델을 사용하면 테이블을 클래스로 표현하고 쿼리를 다트언어로 표현
- 드리프트가 자동으로 해당되는 테이블과 쿼리를 생성한다
#### 18.1.3 Dismissible 위젯
- 위젯을 밀어서 삭제하는 기능을 제공
```dart
Dismissible(
	key: ObjectKey(schedule.id),
	direction: DismissDirection.endToStart,
	onDismissed: (DismissDirection direction) {},
	child: Container(),
);
```
### 구현하기
#### 테이블 모델 구현
#### 테이블 관련 코드 생성
- 드리프트에 Schedule 테이블을 등록해주면 드리프트가 자동으로 테이블과 관련된 기능을 코드로 생성한다
- drift_database.dart 파일 생성
- `flutter pub run build_runner build` 을 입력해 drift_database.g.dart 파일을 생성한다
#### 드리프트 초기화하기
- GetIt 패키지는 의존성을 구현하는 플러그인
  - database 변수를 GetIt.I 를 통해서 프로젝트 어디서든 사용할 수 있게 해준다
#### 일정 데이터 생성하기
- custom_text_field 에 onSaved 와 validator 생성
- HomeScreen 으로부터 selectedDate 변수를 입력받는다
  - DB 메소드를 이용해 INSERT 기능 구현
#### 일정 데이터 읽기
- LocalDatabase 클래스의 watchSchedules() 함수를 사용하여 달력에서 선택한 날짜에 해당하는 일정을 불러온다
#### 일정 데이터 삭제하기
- Dismissible 위젯을 사용해서 왼쪽으로 밀어 삭제하는 기능을 추가
#### 일정 개수 반영하기
- 일정을 선택하면 Today_banner 에 일정 개수를 반영
