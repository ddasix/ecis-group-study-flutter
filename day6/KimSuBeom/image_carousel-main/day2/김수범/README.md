# flutter-study
  - reduce() : 리스트와 같은 Iterable 객체에서 사용되며, 리스트의 요소들을 차례대로 합성
    => 이 함수는 리스트의 첫 번째와 두 번째 요소로 호출되고, 그 결과를 세 번째 요소와 다시 호출하는 방식
  - fold() : reduce()와 유사하게 리스트와 같은 Iterable 객체에서 사용되며, Iterable의 요소들을 하나의 값으로 줄이는 데 사용
    => 초기값 설정이 가능
  - enum(열거형) : 관련된 상수들의 집합을 정의할 때 사용
    => 각 열거형은 열거된 값들로 구성되며, 이 값들은 특정 데이터 타입을 가지지 않는 상수로서 취급


## 상속 클래스
```dart
class Idol{
  final String name;
  final int membersCount;

  //생성자
  Idol(this.name, this.membersCount);

  void sayName(){
    print('im ${this.name}.');
  }

  void sayMemberscount(){
    print('${this.name} memebers No. ${this.membersCount} .');
  }
}

//인터페이스
class GirlGroup implements Idol{
  final String name;
  final int membersCount;

  GirlGroup(
    this.name,
    this.membersCount,
  );

  void sayName(){
    print('Im girl ${this.name}');
  }

  void sayMemberscount(){
    print('${this.name} members No. ${this.membersCount}.');
  }
}

//상속
class BoyGroup extends Idol{
  BoyGroup(
    String name,
    int membersCount,
  ) : super(
      name,
      membersCount,
    );
}
```


## 믹스인
  - 클래스의 일부 기능을 다른 클래스에 재사용할 수 있도록 하는 방법
    => 다중 상속을 대신하는 개념으로, Dart에서는 extends 키워드로 단일 상속을 하면서 with 키워드로 여러 mixin을 적용

```dart
mixin IdolSingMixin on Idol{
  void sing(){
    print('${this.name} singing');
  }
}

class BoyGroup2 extends Idol with IdolSingMixin{
  BoyGroup2(super.name,
    super.membersCount,);

  void sayMale(){
    print('im boy.');
  }
}
```

```dart
void main() {
  BoyGroup bts = BoyGroup('BTS', 7);

  bts.sayMemberscount();
  bts.sayName();

  BoyGroup2 tmt = BoyGroup2('TMT', 8);
  tmt.sing();

  GirlGroup blackpink = GirlGroup('blping', 4)
    ..sayName()
    ..sayMemberscount();
    //캐스케이드 연산자 - 해당 인스턴스의 속성이나 멤버 함수를 사용

  blackpink.sayName();
  blackpink.sayMemberscount();

  final cache = Cache<List<int>>(
    data:[1,2,3],
  );

  print(cache.data.reduce((val, ele)=> val +ele));
}
```

## 제네릭
  - 데이터 타입을 일반화하여 여러 타입에 대해 동작
```dart
class Cache<T>{
  final T data;
  Cache({
    required this.data,
  });
}
```
