
# 비동기 프로그래밍

```dart
import 'dart:async';

// void main(){
//   addNumbers(1,1);
//   //delayed
//   addNumasync(2,2);
//   //async
// }
// 1 + 1 start!
// 1 + 1 code end
// 2 + 2 start!   딜레이 되는 와중에 대기 없이 다음코드 실행
// 1 + 1 = 2   3초 딜레이 후 코드 실행
// 2 + 2 = 4   awiat 가 잇으므로 3초 기다림
// 2 + 2 code end  await 대기 이후 실행
```

###  async
  - 메인이 async 이므로 async 걸림 함수만 실행 가능
    =>차례대로 실행
    =>결괏값 반환

```dart
void main() async {
  final result = await addNumasync(1,1);
  print('result: $result');

  final result2 = await addNumasync(2,2);
  print('result2: $result2');
```

### stream
  - 비동기 이벤트 또는 데이터 시퀀스를 처리하는 데 사용되는 클래스
    => 일반적으로 파일 읽기, 네트워크 요청, 사용자 입력 처리 등에서 사용

```dart
  final controller = StreamController();
  final stream = controller.stream;



  // final streamListener1 = stream.listen((val){
  //   print(val);
  // });
  // controller.sink.add(1);
  // controller.sink.add(1);
  // controller.sink.add(3);
  // controller.sink.add(4);
  // controller.close();
```

### 브로드캐스트스트림
  - 하나의 스트림으로 여러번 listen() 함수를 실행
```dart
  final broadStream = controller.stream.asBroadcastStream();
  final streamListener2 = broadStream.listen((val){
    print('listening 1');
    print(val);
  });

  final streamListener3 = broadStream.listen((val){
    print('listening 2');
    print(val);
  });

  controller.sink.add(1);
  controller.sink.add(1);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.close(); 

  playStream();
}

void addNumbers(int number1, int number2) {
  print('$number1 + $number2 start!');

//딜레이 되는 중에 다음 코드가 실행 되므로 코드 끝이 먼저 나오고 과정이 나중에 나옴
  Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 code end');

}

Future<int> addNumasync(int number1, int number2) async{
  print('$number1 + $number2 start!');
  await Future.delayed(Duration(seconds:3), (){
    print('$number1 + $number2 = ${number1 + number2}');
  });
  print('$number1 + $number2 code end');

  return number1 + number2;
}

//Stream 반환 함수는 async* 로 함수를 선언하고 yield 키워드로 반환
Stream<String> calculate(int number) async*{
  for(int i = 0; i < 5; i++){
    yield 'i = $i';
    await Future.delayed(Duration(seconds:1));
  }

}

playStream(){
  calculate(1).listen((val){
    print(val);
  });
}
```

# 다트 3.0 신규문법

## 레코드
    - 여러값을 묶어 간편하게 다룰 수 있는 불변 데이터 구조
    - 소괄호 ()를 사용하여 생성하며, 값에 접근할 때는 인덱스나 필드 이름을 사용

### 포지셔널 파라미터를 이용한 레코드
```dart
void main(){
    (String, int) su = ('su', 30);
    print(su);
    
    //정의 순서대로 타입을 입력해야함
    (String, int) su1 = (30, 'su'); //에러

    //특정 순서 레코드 값은 '$' 사용
    print(su.$2);

}
```

### 네임드 파라미터를 이용한 레코드
```dart
void main(){
    // 소괄호에 중괄호를 중첩해서 명시
    ({String name, int age}) su = (name:'su', age:30);
    print(su);
}
```

## 구조분해
    - 반환된 타입을 그대로 복제해서 타입 내부에 값을 직접 추출

```dart
void main(){
    final alphabet = ['a', 'b', 'c', 'd', 'e'];
    final[a,b,c,d,e] = ['a', 'b', 'c', 'd', 'e'];

    print(a);
    print(c);

    //스프레드연산자 활용
    final[a1,c1,...,e1] = alphabet;
    
    print(a1);
    print(c1);

    //맵 구조분해
    final nameMap = {'name':'su', 'age':40};
    final {'name':name, 'age':age} = nameMap;

    print('age: $age');

    //클래스 구조분해
    final sucla = Idol(name2: 'su2', age2:20);
    final Idol(name2: name2, age2:age2) = sucla;

    print(name2);

}

class Idol{
    final String name2;
    final int age2;

    Idol({
        required this.name2,
        required this.age2,    
    });
}

```

## switch 문

### 표현식 기능
    - switch 구문을 단일 표현식으로 사용

```dart
void main(){
    var number = 2;

    var result = switch(number){
        1=> 'one',
        2=> 'two',
        3=> 'three',
        _=> 'unknown', //_는 default
    };

    print(result);
}
```
    - 표현식의 중첩 사용, 엄격한 검사
```dart
void main() {
  var number = 2;
  var isEven = true;
  //  bool? isEven; => null 조건이 switch 문에 없기 때문에 엄격한 검사에 의해 에러가 발생
  var result = switch (number) {
    1 => switch (isEven) {
      true => 'one and even',
      false => 'one and odd',
    },
    2 => switch (isEven) {
      true => 'two and even',
      false => 'two and odd',
    },
    _ => 'unknown number',
  };
  
  print(result); // 출력: two and even
}
```

### 패턴매칭
    - 패턴매칭 지원으로 리스트와 객체 등 복잡한 조건 매칭
```dart
class Person {
  final String name;
  final int age;
  
  Person(this.name, this.age);
}

void main() {
  var person = Person('Alice', 30);
  
  var result = switch (person) {
    Person(name: 'Alice', age: 30) => 'Matched Alice, age 30',
    Person(name: 'Bob', age: 25) => 'Matched Bob, age 25',
    _ => 'Unknown person',
  };
  
  print(result); // 출력: Matched Alice, age 30

  switcher([1,2]);
  switcher([3,4]); //no match
  switcher([3,4,1]); //[_,_,_]
}

void switcher(dynamic anything){
    switch(anything){
        case [1,2]:
            print('matchlL [1,2]');
            break;
        case [_,_,_]:
            print('[_,_,_]');
            break;
        case(String a, int b):
            print('match:(String: $a, int: $b)');
            break;
        case _:
            print('no match');

    }
}
```
### 보호구문
    - when 키워드로 보호구문 추가
```dart
void main() {
  (int a, int b) val = (1, 0); // b가 0 이하인 경우 default
  
  var result = switch (val) {
    (1, _) when val.$2 > 0 => '1, _',
    _ => 'default',
  };
  
  print(result); // 출력: 1, _
}
```

## 클래스 제한자
### base 제한자
    - 해당 클래스는 상속만 가능
    - 자식 클래스는 base, final 또는 sealed 제한자 사용

```dart

base class Parent{} //1_a.dart 파일

final class Child extends Parent{} //같은 파일 상속 가능

class child2 extends Parent{} //에러
//class 앞에 제한자가 필요

base class Child3 implements Parent{} //같은 파일 재정의 가능

class Child4 implements Parent{} //에러
//class 앞에 제한자가 필요

/***************************************/

import '1_a.dart';

Parent parent = Parent(); //인스턴스

base class Child extends Parent{} //상속

class child2 extends Parent{} //에러
//class 앞에 제한자가 필요

base class Child3 implements Parent{} //에러
// base 클래스는 implements 가 불가

```

### final 제한자
    - 같은 파일에서 상속과 재정의 가능, 외부 파일에서 불가
    - base 제한자 기능 포함

```dart

final class Parent{}//1_a.dart 파일

final class Child extends Parent{} //같은 파일 상속 가능

class child2 extends Parent{} //에러
//class 앞에 제한자가 필요

base class Child3 implements Parent{} //같은 파일 재정의 가능

/***************************************/

import '1_a.dart';

Parent parent = Parent(); //인스턴스 

class Child extends Parent{} //에러
//상속 불가

class Child3 implements Parent{} //에러
// 재정의 불가

```

### interface 제한자
    - 외부 파일에서 상속받지 못하고 재정의만 할수 있음

```dart

interface class Parent{}

final class Child extends Parent{} //같은 파일 상속 가능

class child2 extends Parent{} //같은 파일 상속 가능
//class 앞에 제한자가 필요 없음

base class Child3 implements Parent{} //같은 파일 재정의 가능

class Child4 implements Parent{} //같은 파일 재정의 가능
//class 앞에 제한자가 필요 없음

/***************************************/

import '1_a.dart';

Parent parent = Parent(); //인스턴스

final class Child extends Parent{} //에러 
//상속 불가

base class Child3 implements Parent{} //재정의 가능

class Child4 implements Parent{} //재정의 가능
//class 앞에 제한자가 필요 없음

```


### sealed 제한자
    - 외부 파일에서 상속, 재정의, 인스턴스화 불가

```dart

interface class Parent{}

/***************************************/

import '1_a.dart';

Parent parent = Parent(); //인스턴스 불가

final class Child extends Parent{} //에러 
//상속 불가

base class Child3 implements Parent{} //에러
//재정의 불가

```

### mixin 제한자
    - 일반 mixin 과 같으면서 상속이 가능

```dart

mixin class MixinExp{}

//상속 가능
class Child1 extends MixinExp{}

//mixin 사용 가능
class Child2 with MixinExp{}

```