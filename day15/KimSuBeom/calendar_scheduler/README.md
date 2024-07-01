# 일정관리 V2
## 사전지식
### SQL, SQLite
- Standard Query Language
- SQL 구조
    - 테이블 : 행 과 열
    - CREATE TABEL
    - INSERT INTO
    - SELECT
    - UPDATE
    - DELETE

### 드리프트 플러그인
- 객체-관계 매핑(Object Relational Mapping, ORM)
    - 데이터베이스의 구조와 객체를 매핑 해주는 기술
    - 해당 속성의 클래스를 생성해서 매핑
    - 테이블 클래스의 인스턴스 형태로 결과 반환

```dart
import 'package:drift/drift.dart';

// create table
class Product extends Table{
    IntColumn get id => integer().autoIncrement()();
    TextColumn get name => text()();
    IntColumn get quantity => integer().withDefault(const Constant(0))();
    IntColumn get price => integer().nullable()();
}

//insert
Future<int> addProduct(){
    return into(product).insert(
        ProductCompanion(
            name: Value('김치'),
            quantity: Value(20),
            price: Value(50000),
        ),
    );
}

//select 
Future<ProductData> getProduct(){
    return (select(product)..where((t) => t.id.equals(1))).getSingle();
}

//update
Future<int> updateProduct(){
    return(update(product)..where((t) => t.id.equals(1),)).write(ProductCompanion(quantity: Value(100),),);
}

//delete
Future<int> deleteProduct(){
    return (delete(product)..where((t) => t.id.equals(1))).go();
}
```

### Dismissible 위젯
- 밀어서 삭제하는 기능 제공
- 삭제하고 싶은 위젯을 감싸고 onDismissed 와 key 매개변수 입력

## 구현하기
### 모델 구현
- lib/model/schedule.dart

### 테이블 관련 코드생성
- 코드 생성을 위해 part 파일 지정
- 대부분 현재 파일 이름에 .g.dart 추가
- 해당 파일이 없을 때 코드 생성 실행하면 자동으로 실행

### 쿼리 구현하기
- SELECT 일회성 데이터 get()
    - 변화가 있을때마다 자동으로 데이터 불러오는 watch()
- 드리프트에서 필터링 할때는 기호 대신 제공 함수로 비교
- 코드 생성을 하면 모든 테이블의 Companion 클래스가 생성
    - 데이터를 생성할 때는 꼭 생성된 Companion 클래스를 통해 값을 넣어줌
- 드리프트 DB 클래스는 필수로 schemaVersion 값 지정 필요
    LaxyDatabase 필수 : 데이터베이스 생성할 위치 정보

### 드리프트 초기화하기
- LocalDatabase 클래스 인스턴스 화
- get_it 패키지로 의존성 주입
    - GetIt.I 를 통해 database 변수를 프로젝트 어디든 사용 가능

### 일정 데이터 생성하기
- Form 위젯 사용
    - key : GlobalKey 값
    - key 를 이용해서 Form 내부의 TextFormField를 일괄 조작
- validator() 함수 : Form 의 서브에 있는 모든 TextFormField 의 vaildate 매개변수에 입력된 함수 실행
    - 모든 함수들이 null 을 반환하면 true 반환
- createSchedule 함수 실행
    - GetIt으로 LocalDatabase 인스턴스 가져온 후 실행
    - Companion으로 실제 테이블에 입력될 값들을 Value 클래스로 싸서 입력

### 일정 데이터 읽기
- watchSchedule() 함수 사용
    - Stream을 반환하므로 StreamBuilder 로 데이터 변경 시 위젯 새로 랜더링

### 일정 데이터 삭제
- Dismissible
    - 왼쪽으로 미는 제스처로 삭제

### 일정 개수 반영
- StreamBuilder 로 Today Banner를 감싸 줌