# 일정관리 앱

## 데이터베이스 적용하기

### `SQL`, `SQLite`

- SQL: 데이터 베이스 언어
- 데이터베이스의 종류: Oracle, MySQL, PostgreSQL, DB2, SQLServer 등
- SQLite: 데이터베이스의 종류로 프론트엔드에서 많이 사용 함.

### `drift` 플러그인

- 객체-관계 모델
- 테이블을 클래스로 표현하고 쿼리를 Dart 언어로 표현하면 드리프트가 자동으로 해당 테이블과 쿼리를 생성함.

### 테이블 생성

```sql
CREATE TABLE product (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR NOT NULL,
    quantity INT DEFAULT 0,
    price INT NOT NULL
)
```

```dart
import package:drift/drift.dart;

class Product extends Table {
    IntColumn get id => integer().autoIncrement()();
    TextColumn get name => text()();
    IntColumn get quantity => integer().withDefault(const Constant(0))();
    IntColumn get price => integer().nullable()();
}
```

### INSERT

```sql
INSERT INTO product (name, quantity, price)
VALUES ('김치', 20, 50000)
```

```dart
Future<int> addProduct() {
    return into(product).insert(
        ProductCompanion(
            name: Value('김치'),
            quantity: Value(20),
            price: Value(50000),
        )
    );
}
```

### SELECT

```sql
SELECT & FROM product WHERE id = 1;
```

```dart
Future<ProductData> getProduct() {
    return (
        select(product)
            ..where(
                (pdt) => pdt.id.equals(1),
            ),
        ).getSingle();
}
```

### UPDATE
```sql
UPDATE product SET quantity = 100 WHERE id = 1;
```
```dart
Future<int> updateProduct() {
    return (
        update(product)
            ..where(
                (pdt) => pdt.id.equals(1),
            )
        ).write(
            ProductCompanion(
                quantity: Value(100)
            )
        );
}
```

### DELETE
```sql
DELETE FROM product WHERE id = 1;
```
```dart
Future<int> deleteProduct() {
    return (
        delete(product)
            ..where(
                (pdt) => pdt.id.equals(1),
            )
        ).go();
}
```

## `Dismissible`위젯
- 위젯을 밀어서 삭제 하는 기능 
```dart
Dissmissible(
    key: ObjectKey(schedule.id),
    direction: DissmissDirection.endToStart,
    onDissmissed: (DissmissDirection direction) {},
    child: Container(),
);
```

## 실습
