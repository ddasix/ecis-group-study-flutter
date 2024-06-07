# 단계 1 - 다트 언어 마스터하기
## ch03 다트 비동기 프로그래밍
### 3.1 동기 vs. 비동기 프로그래밍
- 동기 : 요청 후 응답이 오면 다음 코드를 진행하는 방식
- 비동기 : 요청 후 응답을 기다리지 않고 다음 코드를 진행하는 방식
  - 언제든 응답이 오면 즉시 응답처리
  - 응답 순서가 요청한 순서와 다를 수 있음
  - 컴퓨터 자원을 낭비하지 않고 더욱 효율적으로 코드를 실행할 수 있음
  - 대용량 데이터 조회, 복잡한 계산, 이미지 인코딩등 시간이 걸리는 작업에 유용함
### 3.2 Future
- 제네릭으로 어떤 미래의 값을 받아올지 정할 수 있음
```dart
void main(){
  Future<String> name;    // 미래에 받을 String값
  Future<int> number;     // 미래에 받을 int값
  Future<bool> isOpened;  // 미래에 받을 boolean값
}
```
- Future.delayed()를 사용한 비동기 예시
  ```dart
  void main() {
    addNumbers(1, 1);
  }

  void addNumbers(int number1, int number2){
    print('$number1 + $number2 계산 시작!');

    // Future.delayed()를 사용하면 일정 시간 후에 콜백 함수를 실행할 수 있음
    Future.delayed(Duration(seconds: 3), (){
      print('$number1 + $number2 = ${number1 + number2}');
    });

    print('$number1 + $number2 코드 실행 끝');
  }
  // 예상 결과
  1 + 1 계산 시작!
  1 + 1 = 2
  1 + 1 코드 실행 끝

  // 실행 결과
  1 + 1 계산 시작!
  1 + 1 코드 실행 끝
  1 + 1 = 2

  // 위에 결과처럼 '예상 결과'가 아닌 '실행 결과'의 순서로 나온 이유는 Future.delayed()는 비동기 연산이기 때문에 CPU가 3초간 대기해야 한다는 메시지를 받으면 리소스를 허비하지 않고 뒤의 코드를 바로 실행했기 때문
  ```
### 3.3 async와 await
- 코드가 작성된 순서대로 실행되지 않는다면 개발자 입장에서 헷갈릴 수 있음
- async와 await 키워드를 사용하면 비동기 프로그래밍을 유지하면서도 코드 가독성을 유지할 수 있음
```dart
void main() {
  addNumbers(1, 1);
}

// async 키워드는 함수 매개변수 정의와 바디 사이에 입력
Future<void> addNumbers(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');

  // await는 대기하고 싶은 비동기 함수 앞에 입력
  await Future.delayed(Duration(seconds: 3), (){
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 코드 실행 끝');
}
// 실행 결과
1 + 1 계산 시작!
1 + 1 = 2
1 + 1 코드 실행 끝

// 비동기 프로그래밍을 사용하였지만 async와 await의 사용으로 코드가 작성된 순서대로 프로그램 실행
```
- 위의 addNumbers() 함수를 두 번 실행하여 비동기 프로그래핑 증명 예시
  ```dart
  void main() {
    addNumbers(1, 1);
    addNumbers(2, 2);
  }

  ... 생략 ...

  // 실행 결과
  1 + 1 계산 시작!
  2 + 2 계산 시작!
  1 + 1 = 2
  1 + 1 코드 실행 끝
  2 + 2 = 4
  2 + 2 코드 실행 끝

  // 출력 결과를 함수별로 나눠서 보면 각 addNumber() 함수의 실행 결과가 예상한 코드 순서대로 순차 실행되었지만 addNumbers(1, 1)가 끝나기 전에 addNumber(2, 2)가 실행됨
  // 이유는 addNumbers() 함수가 비동기 프로그래밍으로 실행되었기 때문
  ```
- addNumbers(1, 1)와 addNumbes(2, 2)가 순차적으로 실행되길 원한다면 아래와 같이 async와 await 키워드를 추가
  ```dart
  void main() async {
    await addNumbers(1, 1);
    await addNumbers(2, 2);
  }

  // async 키워드는 함수 매개변수 정의와 바디 사이에 입력
  Future<void> addNumbers(int number1, int number2) async {
    print('$number1 + $number2 계산 시작!');

    // await는 대기하고 싶은 비동기 함수 앞에 입력
    await Future.delayed(Duration(seconds: 3), (){
      print('$number1 + $number2 = ${number1 + number2}');
    });

    print('$number1 + $number2 코드 실행 끝');
  }

  // 실행 결과
  1 + 1 계산 시작!
  1 + 1 = 2
  1 + 1 코드 실행 끝
  2 + 2 계산 시작!
  2 + 2 = 4
  2 + 2 코드 실행 끝
  ```
3.3.1 결괏값 반환받기
- await 키워드를 적용해도 일반 함수처럼 변수에 반환값을 저장하고 활용할 수 있음
```dart
void main() async {
  final result = await addNumbers(1, 1);
  print('결괏값 $result');  // 일반 함수와 동일하게 반환값을 받을 수 있음
  final result2 = await addNumbers(2, 2);
  print('결괏값 $result2');
}

Future<int> addNumbers(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');

  await Future.delayed(Duration(seconds: 3), (){
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 코드 실행 끝');

  return number1 + number2;
}
```
### 3.4 Stream
- Future는 반환값을 딱 한 번 받아내는 비동기 프로그래밍에 사용
- 지속적으로 값을 반환 받을 때는 Stream을 사용
- Stream은 한 번 리슨<sup>listen</sup>하면 Stream에 주입되는 모든 값들을 지속적으로 받아옴
3.4.1 스트림 기본 사용법
```dart
import 'dart:async';

void main() {
  final controller = StreamController();  // StreamController 선언
  final stream = controller.stream;  // Stream 가져오기

  // Stream에 listen() 함수를 실행하면 값이 주입될 때마다 콜백 함수를 실행할 수 있음
  final streamListener1 = stream.listen((val) {
    print(val);
  });

  // Stream에 값을 주입할 때는 sink.add() 함수를 실행하면 됨
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
}

// 실행 결과
1
2
3
4
```
3.4.2 브로드캐스트 스트림
- 스트림은 단 한 번만 listen()을 실행할 수 있음
- 하나의 스트림을 생성하고 여러 번 listen() 함수를 실행하고 싶을 때 사용
```dart
import 'dart:async';

void main() {
  final controller = StreamController();

  // 여러 번 리슨할 수 있는 Broadcaste Stream 객체 생성
  final stream = controller.stream.asBroadcastStream();

  // 첫 listen() 함수
  final streamListener1 = stream.listen((val) {
    print('listening 1');
    print(val);
  });

  // 두 번째 listen() 함수
  final streamListener2 = stream.listen((val) {
    print('listening 2');
    print(val);
  });

  // add()를 실행할 때마다 listen()하는 모든 콜백 함수에 값이 주입됨
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);

}

// 실행 결과
listening 1
1
listening 2
1
listening 1
2
listening 2
2
listening 1
3
listening 2
3
```
3.4.3 함수로 스트림 반환하기
- StreamController를 직접 사용하지 않고도 직접 스트림을 반환하는 함수를 작성할 수 있음
- Future를 반환하는 함수는 async로 함수를 선언하고 return 키워드로 값을 반환하면 됨
- 스트림을 반환하는 함수는 async*로 함수를 선언하고 yield 키워드로 값을 반환해주면 됨
```dart
import 'dart:async';

// Stream을 반환하는 함수는 async*로 선언
Stream<String> calculate(int number) async* {
  for (int i = 0; i < 5; i++) {
    // StreamController의 add()처럼 yield 키워드를 이용해서 값 반환
    yield 'i = $i';
    await Future.delayed(Duration(seconds: 1));
  }
}

void playStream() {
  // StreamController와 마찬가지로 listen() 함수로 콜백 함수 입력
  calculate(1).listen((val) {
    print(val);
  });
}

void main() {
  playStream();
}

// 실행 결과
i = 0
i = 1
i = 2
i = 3
i = 4
```
## ch04 다트 3.0 신규 문법
### 4.1 레코드
- 레코드<sup>record</sup>는 다트 3.0 이상부터 사용할 수 있는 새로운 타입
- 레코드는 포지셔널 파리미터<sup>positional parameter</sup>나 네임드 파라미터<sup>named parameter</sup>중 한 가지 방식을 적용하여 사용가능
- 두 방식은 모두 괄호 안에 쉼표로 구분하여 작성

4.1.1 포지셔널 파라미터를 이용한 레코드
- 포지셔널 파리미터를 이용한 레코드는 포지셔널 파리미터로 표시한 타입 순서를 반드시 지켜야함
```dart
void main() {
  // 정확한 위치에 어떤 타입의 값이 입력될지 지정할 수 있음
  // (String, int)는 첫 번째 값은 String 타입이고 두 번째 값은 int 타입임
  (String, int) minji = ('민지', 20);
  // ('민지', 20) 출력
  print(minji);
}
```
- 만약 레코드에 정의한 순서대로 타입을 입력하지 않으면 에러가 발생함
```dart
void main() {
  // Invalid Assignment 에러
  (String, int) minji = (20, '민지');
  print(minji);
}
```
- 두 개 이상의 값을 조합해서 레코드를 만들 수도 있음
- 레코드에 정의할 수 있는 값의 갯수제한 없음
```dart
// 3개의 타입으로 제한한 레코드 예시
void main() {
  (String, int, bool) minji = ('민지', 20, true);
  // (민지, 20, true)
  print(minji);
}
```
- 레코드의 모든 값을 사용하지 않고 특정 순서의 레코드 값을 가져오고 싶다면 '$'를 사용
```dart
void main() {
  (String, int, bool) minji = ('민지', 20, true);

  // 민지
  print(minji.$1);
  // 20
  print(minji.$2);
  // true
  print(minji.$3);
}
```
4.1.2 네임드 파라미터를 이용한 레코드
- 포지셔널 파리미터와는 다르게 입력 순서를 지킬 필요가 없음
- 소괄호에 중괄호를 중첩하여 타입과 변수 이름을 쉼표로 구분하고 명시해줘야 함
```dart
void main() {
  // Named Parameter 형태로 Record를 선언하는 방법
  // 다른 Named Parameter와 마찬가지로 순서는 상관없음
  ({String name, int age}) minji = (name: '민지', age: 20);

  // (age: 20, name: 민지) 출력
  print(minji);
}
```
### 4.2 구조 분해
- 구조 분해<sup>destructuring</sup>는 값을 반환받을 때 단순히 하나의 변수로 받아오지 않음
- 반환된 타입을 그대로 복제해서 타입 내부에 각각의 값을 직접 추출해오는 문법

4.2.1 리스트에서의 구조 분해 사용 예제
```dart
void main() {
  // 아래 코드와 같지만 구조 분해를 사용하면 한 줄에 해결할 수 있음
  // final newJeans = ['민지', '해린'];
  // final minji = newJeans[0];
  // final haerin = newJeans[1];
  final [minji, haerin] = ['민지', '해린'];

  // 민지 출력
  print(minji);

  // 해린 출력
  print(haerin);
}
```
4.2.2 리스트에서의 스프레드 연산자를 이용한 구조 분해 사용 예제
```dart
void main() {
  final numbers = [1, 2, 3, 4, 5, 6, 7, 8];

  // 스프레드 연산자를 사용하게 되면 중간의 값들을 버릴 수 있음
  final [x, y, ..., z] = numbers;

  // 1 출력
  print(x);

  // 2 출력
  print(y);

  // 8 출력
  print(z);
}
```
4.2.3 맵에서의 구조 분해 사용 예제
```dart
void main() {
  final minjiMap = {'name': '민지', 'age': 19};
  // 위의 맵의 구조와 똑같은 구조로 구조 분해하면 됨
  final {'name': name, 'age': age} = minjiMap;

  // name: 민지
  print('name: $name');

  // age: 19
  print('age: $age');
}
```
4.2.4 클래스에서의 구조 분해 사용 예제
```dart
void main() {
  final minJiIdol = Idol(name: '민지', age: 19);

  // 클래스의 생성자 구조와 똑같이 구조 분해하면 됨
  final Idol(name: name, age: age) = minJiIdol;

  // 민지 출력
  print(name);

  // 19 출력
  print(age);
}

class Idol {
  final String name;
  final int age;

  Idol({
    required this.name,
    required this.age,
  });
}
```
### 4.3 switch문
- switch문은 다트 언어가 3.0 버전으로 업데이트되면서 아래의 4가지가 추가됨 
  - 스위치 표현식<sup>switch expression</sup>  
  - 패턴 매칭<sup>pattern matching</sup>  
  - 완전 확인<sup>exhausiveness checking</sup>  
  - 가드 절<sup>guard clause</sup>

4.3.1 표현식 기능
- 코드는 표현식<sup>exprssion</sup>과 문<sup>statement</sup>으로 나눌 수 있음
- 표현식 : 어떠한 값을 만들어내는 코드(예 1 + 1은 값 2를 만드는 표현식)
- 문 : 기본 단위이자 가장 작은 코드 실행 단위로 즉, 명령문이며 문에는 선언문, 할당문, 반복문 등이 있음(예 var a = 3)
- 다트 3.0 부터는 switch문을 함수처럼 사용하여 직접 값을 반환받을 수 있는 절 기능이 추가됨
```dart
void main() {
  String dayKor = '월요일';

  // switch문이 함수처럼 값을 반환함
  String dayEnglish = switch (dayKor) {
    // '=>'를 사용하면 switch문 조건에 맞을 때 값을 반환할 수 있음
    '월요일' => 'Monday',
    '화요일' => 'Tuesday',
    '수요일' => 'Wednesday',
    '목요일' => 'Thursday',
    '금요일' => 'Friday',
    '토요일' => 'Saturday',
    '일요일' => 'Sunday',
    // _는 default와 같은 의미로 사용됨
    _ => 'Not Found',
  };

  print(dayEnglish);
}
```
4.3.2 패턴 매칭
- 패턴 매칭<sup>pattern matching</sup>은 다트 3.0에 추가된 강력한 기능 중 하나
- 특히 switch문을 사용할 때 패턴 매칭을 통해서 더욱 복잡한 조건을 형성할 수 있어 유용함
```dart
void switcher(dynamic anything) {
  switch (anything) {
    // 정확히 'aaa' 문자열만 매치
    case 'aaa':
      print('match: aaa');
      break;
    // 정확히 [1, 2] 리스트만 매치
    case [1, 2]:
      print('match: [1, 2]');
      break;
    // 3개의 값이 들어 있는 리스트를 모두 매치
    case [_, _, _]:
      print('match [_,_,_]');
      break;
    // 첫 번째와 두 번째 값에 int가 입력된 리스트를 매치
    case [int a, int b]:
      print('match: [int $a, int $b]');
      break;
    // 첫 번째 값에 String, 두 번째 값에 int가 입력된 Record 타입을 매치
    case (String a, int b):
      print('match: (String: $a, int: $b)');
      break;
    // 아무것도 매치되지 않을 경우 실행함
    default:
      print('no match');
  }
}

void main() {
  // match: aaa 출력
  switcher('aaa');
  // match: [1, 2] 출력
  switcher([1, 2]);
  // match: [_, _, _] 출력
  switcher([3, 4, 5]);
  // match: [int 6, int 7] 출력
  switcher([6, 7]);
  // match: (String: 민지, int: 19) 출력
  switcher(('민지', 19));
  // no match 출력
  switcher(8);
}
```
4.3.3 엄격한 검사
- 엄격한 검사<sup>exhaustiveness checking</sup>는 코드가 입력받을 수 있는 모든 조건을 전부 확인하고 있는지 체크하는 기술
- 다트 3.0에서는 switch문에 엄격한 검사가 추가되어 모든 조건을 확인하고 있는지 빌드할 때 확인가능
```dart
void main(){
  // val에 입력될 수 있는 값은 true, false, null
  bool? val;

  // null 조건을 입력하지 않았기 때문에 non exhaustive switch statement 에러가 발생
  // null case를 추가하거나 default case를 추가해야 에러가 발생하지 않음
  switch(val){
    case true:
      print('true');
    case false:
      print('false');
  };
}
```
4.3.4 보호 구문
- switch문에는 when 키워드로 보호 구문<sup>guard clause</sup>을 추가할 수 있도록 업데이트됨
- when 키워드는 boolean으로 반환할 조건을 각 case문에 추가할 수 있음
- when 키워드 뒤에오는 조건이 true를 반환하지 않으면 case 매치가 안됨
```dart
void main() {
  (int a, int b) val = (1, -1);

  // default가 출력됨
  // 만약에 b 값을 0 초과로 변경하면 1, _를 출력할 수 있음
  switch (val) {
    case (1, _) when val.$2 > 0:
      print('1, 2');
      break;
    default:
      print('default');
  }
}
```
### 4.4 클래스 제한자
- 다트 3.0 버전에서는 다양한 클래스 제한자<sup>class modifiers</sup>가 새로 추가됨
- 추가된 클래스 제한자는 `base`, `final`, `interface`, `sealed`, `mixin`
- 모든 클래스 제한자는 class 키워드 앞에 명시
- 클래스 제한자를 명시한 클래스는 해당 클래스를 사용하는 파일이 아닌 다른 파일에 선언해야 정상으로 기능이 작동함

4.4.1 base 제한자
- base 제한자는 base 클래스의 기능을 강제하는 제한자
- base 키워드를 사용하게 되면 해당 클래스는 오직 상속만 가능
- base 클래스가 아닌 자식 클래스는 꼭 `base`, `final` 또는 `sealed` 제한자를 함께 사용해줘야 함  

```dart
# base_class_a.dart

base class Parent{}
```
```dart
# base_class_b.dart

import 'base_class_a.dart';

// 인스턴스화 가능
Parent parent = Parent();

// 가능
base class Child extends Parent{}

// subtype of base or final is not base final or sealed 에러 발생
// base / sealed / final 제한자 중 하나가 필요
class Child2 extends Parent{}

// subtype of base or final is not base final or sealed 에러 발생
// base 클래스는 implement 불가능
class Child3 implements Parent{}
```
4.4.2 final 제한자
- 같은 파일에서 상속<sup>extend</sup>과 재정의<sup>implement</sup>를 할 수 있지만 외부 파일에서는 할 수 없음
- base 제한자의 기능을 모두 포함함
```dart
# final_class_a.dart

final class Parent{}

// 같은 파일에서 extend 가능
class Child extends Parent{}

// 같은 파일에서 implement 가능
class Child2 implements Parent{}
```
```dart
# final_class_b.dart

import 'final_class_a.dart';

// 인스턴스화 가능
Parent parent = Parent();

// 외부 파일에서 extend 불가능
class Child extends Parent{}

// 외부 파일에서 implement 불가능
class Child2 implements Parent{}
```
4.4.3 interface 제한자
- 외부 파일에서 상속받지 못하며 재정의만 할 수 있도록 제한
```dart
# interface_class_a.dart

interface class Parent{}

// 같은 파일에서 extend 가능
class Child1 extends Parent{}

// 같은 파일에서 implement 가능
class Child2 implements Parent{}
```
```dart
# interface_class_b.dart

import 'interface_class_a.dart';

// 인스턴스화 가능
Parent parent = Parent();

// 외부 파일에서 extend 불가능
class Child1 extends Parent{}

// 외부 파일에서 implement만 가능
class Child2 implements Parent{}
```
4.4.4 sealed 제한자
- sealed 클래스를 파일 외부에서 `상속`, `재정의`, `인스턴스화` 제한
```dart
# sealed_class_a.dart

sealed class Parent{}
```
```dart
# sealed_class_b.dart

import 'sealed_class_a.dart';

// 인스턴스화 불가능
Parent parent = Parent();

// 외부 파일에서 extend 불가능
class Child1 extends Parent {}

// 외부 파일에서 implement 불가능
class Child2 implements Parent {}

```
4.4.5  mixin 제한자
- 다트 3.0부터는 mixin을 클래스에 사용할 수 있게 됨
- 일반 mixin과 같은 역할을 하면서도 상속이 가능하다는 장점
```dart
# mixin_class.dart

mixin class MixinExample{}

// extend 가능
class Child1 extends MixinExample{}

// mixin으로 사용 가능
class Child2 with MixinExample{}
```
