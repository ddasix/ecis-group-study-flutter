# Dart 언어 마스터 하기
## 3. Dart 비동기 프로그래밍
### 3.1. 동기 vs 비동기
- 그림으로 표시 하면 아래와 같음.  
![alt text](image.png)
- 동기: 함수를 실행하면 요청결과를 기다림
- 비동기
    - 요청한 결과를 기다리지 않음
    - 결과 순서가 요청순서와 다를 수 있음.
    - 사용예: API 호출, 이미지 인코딩, 계산이 오래걸리는 호출
### 3.2. Future
- 비동기 프로그래밍에서 응답 받을 값의 제네릭을 지정할 수 있음.
```dart
void main() {
    addNumbers(1, 2);
}

void addNumbers(int num1, int num2) {
    print('$num1 + $num2 실행 시작');

    Future.delayed(Duration(seconds: 3), () {
        print('$num1 + $num2 = ${num1 + num2}');
    });

    print('$num1 + $num2 실행 끝');
}
# 결과  // 실행 결과 순서가 보장되지 않음.
1 + 2 실행 시작
1 + 2 실행 끝
1 + 2 = 3
```
### 3.3. async와 await
- 순서대로 실행되지 않으면 개발자 입장에서 개발하기 여러움.
- async, await 키워드를 사용하면 비공기 프로그램을 유지하면서도 코드 가독성 유지 가능.
- 요청순서와 결과 순서를 보장받을 수 있음.
```dart
Future<void> addNumbers(int num1, int num2) async {
    print('$num1 + $num2 실행 시작');
    await Future.delayed(Duration(seconds: 3), () {
        print('$num1 + $num2 = ${num1 + num2}');
    });
    print('$num1 + $num2 실행 끝');
}
# 결과  // await/async를 사용하면 순서가 보장 됨.
1 + 2 실행 시작
1 + 2 = 3
1 + 2 실행 끝
```

- `addNumbers(1,1)`가 실행이 되는동안 결과를 기다리지 않고 `addNumbers(1,2)`이 실행이 됨
- `addNumbers` 함수 블록 내부는 `await`으로 작동 하지만 외부는 비동기로 작동함..
```dart
void main() {
    addNumbers(1,1);
    addNumbers(1,2);
}
# 결과  
1 + 1 실행 시작
1 + 2 실행 시작
1 + 1 = 2
1 + 2 실행 끝
1 + 2 = 3
1 + 2 실행 끝
```

- 만약 함수도 순차적으로 실행하고 싶다면 아래와 같이 `async/await`을 추가 하면 됨.
- `addNumbers(1,1)`가 먼저 실행이 끝나고 `addNumbers(1,2)`가 실행이 됨.
```dart
Future<void> addNumbers(int num1, int num2) async {
    print('$num1 + $num2 실행 시작');
    await Future.delayed(Duration(seconds: 3), () {
        print('$num1 + $num2 = ${num1 + num2}');
    });
    print('$num1 + $num2 실행 끝');
}

void main() async {
    await addNumbers(1,1);
    await addNumbers(1,2);
}
```

#### 3.3.1 결과값 받기
- `await`키워드를 적용했지만 일반함수처럼 변수에 값을 할당할 수 있음.
```dart
Future<int> addNumbers(int num1, int num2) async {
    print('$num1 + $num2 실행 시작');
    await Future.delayed(Duration(seconds: 3), () {
        print('$num1 + $num2 = ${num1 + num2}');
    });
    print('$num1 + $num2 실행 끝');

    return num1 + num2;
}

void main() async {
    final Future<int> result1 = await addNumbers(1, 1);
    print('결과1: $result1');
    final Future<int> result2 = await addNumbers(1, 2);
    print('결과2: $result2');
}
# 결과  
1 + 1 실행 시작
1 + 1 = 2
1 + 2 실행 끝
결과1: 2
1 + 2 실행 시작
1 + 2 = 3
1 + 2 실행 끝
결과2: 3
```
### 3.4. Stream
```
- `Future`는 반환값을 딱 한번 받아내는 비동기 프로그래밍임.
- 지속적으로 값을 받을 때는 `Stream`을 사용함.
- `Stream`은 한번 `Listen`하면 `Stream`에 주입 되는 모든 값들을 지속적으로 받아옴.
```
1. 기본사용법
    ```dart
    import 'dart:async';

    void main() {
        final controller = StreamController();
        final stream = controller.stream();

        final streamListener1 = stream.listen((val) {
            print(val);
        });

        // Stream에 값 주입하기
        controller.sink.add(1);
        controller.sink.add(2);
        controller.sink.add(3);
        controller.sink.add(4);
    }
    ```
2. 브로드캐스팅 스트림
- `Stream`은 단한번만 `listen` 실행 가능함.
- 하나의 `Stream`으로 여러번 `listen` 하고 싶을 때 사용함.
    ```dart
    import 'dart:async';

    void main() {
        final controller = StreamController();
        final stream = controller.stream.asBroadcastStream();

        final streamListener1 = stream.listen((val) {
            print('listening 1');
            print(val);
        });

        final streamListener2 = stream.listen((val) {
            print('listening 2');
            print(val);
        });

        // Stream에 값 주입하기
        controller.sink.add(1);
        controller.sink.add(2);
        controller.sink.add(3);
        controller.sink.add(4);
    }
    ```
3. 함수로 스트림 반환받기
- `StreamController`를 사용하지 않고도 스트림을 반환하는 함수를 작성할 수 있음.
- Future를 반환하는 함수: async로 함수를 선언하고 return 키워드로 값을 반환.
- Stream을 반환하는 함수: async*로 함수를 선언하고 yield 키워드로 값을 반환.
    ```dart
    import 'dart:async';

    Stream<String> calulate(int number) async* {
        for(int i; i < 5; i++) {
            yield 'i = $i';
            await Future.delayed(Duration(seconds: 1));
        }
    }

    void playStream() {
        calulate(1).listen((val) {
            print(val);
        });
    }

    void main() {
        playStream();
    }
    ```
## 4. Dart 3.0 신규 문법
### 4.1. 레코드
```
포지셔널 파라미터와 네임드 파라미터 중 한가지 방식을 적용하여 사용할 수 있음.
```
1. 포지셔널 파라미터를 이용한 레코드
```dart
void main() {
    (String, int) record = ('레코드', 20);

    print(record);
}
```
- 순서대로 타입을 입력하지 않으면 오류 발생 함.
    ```dart
        (String, int) record = (20, '레코드'); // Invalid Assignment Error

        print(record);
    ```
- 정의 개수에는 제한은 없음.
    ```dart
        (String, int, bool) record = ('레코드', 20, false);
        
        print(record);
    ```
- 특정 순서의 값을 가져오고 싶으면 `$`를 사용함.
    ```dart
        (String, int, bool) record = ('레코드', 20, false);
        
        print(record.$1);
        print(record.$2);
        print(record.$3);
    ```
2. 네임드 파라미터를 이용한 레코드
```dart
void main() {
    ({String name, int age}) record = (name: '레코드', age: 20);
        
    print(record);
}
```
### 4.2. 구조분해
1. List에서 구조분해
```dart
void main() {
    final [name1, name2] = ['name1', 'name2'];

    print(name1);
    print(name2);
}
```
2. 스프레드 연산자를 이용한 구조분해
```dart
void main() {
    final numbers = [1,2,3,4,5,6,7,8];
    final [x, y, ..., z] = numbers; // 중간 값은 버리기

    print(x);
    print(y);
    print(z);
}
```
3. Map에서 구조분해
```dart
void main() {
    final map1 = {'name': 'map1', 'age': 19};
    final {'name': name, 'age': age} = map1;

    print('name: $name');
    print('age: $age');
}
```
4. 클래스에서 구조분해
```dart
class Idol {
    final String name;
    final int age;

    Idol({
        required this.name,
        required this.age,
    });
}

void main() {
    final klass = Idol(name: 'IDOL', age: 19);

    final Idol(name: name, age: age) = klass;

    print(name);
    print(age);
}
```
### 4.3. Switch
1. 표현식 기능
```dart
void main() {
    String dayKor = '월요일';

    String dayEng = switch(dayKor) {
        '월요일' => 'Mon',
        '화요일' => 'Tue',
        '수요일' => 'Wed',
        '목요일' => 'Thu',
        '금요일' => 'Fri',
        '토요일' => 'Sat',
        '일요일' => 'Sun',
        _ => 'Not Found',   // default
    }

    print(dayEng);
}
```

2. 패턴 매칭
```dart
void switcher(dynamic anything) {
    switch (anything) {
        case 'aaa':     // 값이 aaa인 String 매치
            print('aaa');
            break;
        case [1, 2]:    // 값이 1,2가 들어 있는 List 매치
            print('[1,2]');
            break;
        case [_,_,_]:   // 3개의 값이 들어 있는 List 매치
            print('[_,_,_]');
            break;
        case [int a, int b]:    // 첫번째와 두번째 모두 int인 리스트 매치
            print('[$a,$b]');
            break;
        case (String a, int b): // String과 int가 순서대로 들어있는 레코드 매치
            print('(String: $a, int: $b)');
            break;
        default:    // 매치되는게 없을 때
            print('No matching');
            
    }
}

void main() {
    switcher('aaa');    // aaa
    switcher([1,2]);    // [1,2]
    switcher([4,5,6]);  // [_,_,_]
    switcher([6,7]);    // [6,7]
    switcher(('테스트', 19));   // (String: 테스트, int: 19)
    switcher(8);    // No matching
}
```
3. 엄격한 검사(exhausiveness checking)
- switch에서 모든 조건을 확인해야 함.
    ```dart
    void main() {
        bool? val;

        // 오류 발생함.
        // bool에 ?가 추가 되어 nullable한 변수이므로 True, False, null 가능
        // null case를 추가 하거나 default를 추가 해야 함.
        switch(val) {
            case true:
                print('True');
                break;
            case false:
                print('False');
                break;
        }
    }
    ```
4. 보호구문
- switch문에 `Guard Clause` 구문을 추가 할 수 있음.
```dart
void main() {
    (int a, int b) val = (1, -1);

    switch(val) {
        case (1, _) when val.$2 > 0: // val의 2번째 값이 0보다 크면 해당 case에 걸림
            print('1, _');
            break;
        default:
            print('default');
    }
}
```
### 4.4. 클래스 제한자
1. `base` 제한자
    - `base`클래스의 기능을 강제하는 제한자
    - `base`클래스는 `상속만 가능`
    - `base`클래스를 상속받은 자식 클래스는 `base`, `final`, `sealed` 제한자를 함께 사용 해야 함.
    ```dart
    # a.dart

    base class Parent {}
    ```
    ```dart
    # b.dart

    import 'a.dart';

    Parent parent = Parent();   // 가능
    base class Child extends Parent {} // 가능
    class Child1 extends Parent {} // 불가; `base`, `final`, `sealed` 제한자를 함께 사용해야 함
    class Child2 implements Parent {} // 불가; `base`, `final`, `sealed` 제한자를 함께 사용해야 함
    ```
2. `final`
    - 같은 파일에서 `상속`, `재정의 가능`
    - 외부 파일에서 `상속불가`, `인스턴스화 가능`, `재정의 불가`
    - `base`의 모든 기능을 포함함.
    ```dart
    # a.dart
    final class Parent {}
    ```

    ```dart
    # b.dart
    import 'a.dart';

    Parent parent = Parent();   // 가능
    class Child1 extends Parent {} // 불가
    class Child2 implements Parent {} // 불가
    ```
3. `interface`
    - 해당 클래스 파일 외부에서는 `상속불가`, `인스턴스화 가능`, `재정의 가능`
    ```dart
    # a.dart
    interface class Parent {}
    ```
    ```dart
    # b.dart

    import 'a.dart';

    Parent parent = Parent(); // 가능
    class Child1 extends Parent {} // 불가
    class Child2 implements Parent {} // 가능
    ```
4. `sealed`
    - 파일 외부에서 `상속불가`, `인스턴스화 불가`, `재정의 불가`(파일 내부에서만 가능)
    ```dart
    # a.dart
    sealed class Parent {}
    ```
    ```dart
    # b.dart
    import 'a.dart';

    Parent parent = Parant(); // 불가
    class Child1 extends Parent {} // 불가
    class Child2 implements Parent {} // 불가
    ```
5. `mixin`
    - 상속하여 사용도 가능함.
    ```dart
    mixin class MixinExample {}

    class Child1 extends MixinExample {}

    class Child2 with MixinExample {}
    ```
## 기타. 클래스 제한자를 조합했을 때 허가되는 기능표
|선언|인스턴스화 가능여부|상속 가능여부|인터페이스구현 가능여부|믹스인 가능여부|엄격한 검사 가능여부|
|---:|:---:|:---:|:---:|:---:|:---:|
|class|✅|✅|✅|❌|❌|
|base class|✅|✅|❌|❌|❌|
|interface class|✅|❌|✅|❌|❌|
|final class|✅|❌|❌|❌|❌|
|sealed class|❌|❌|❌|❌|✅|
|abstract class|❌|✅|✅|❌|❌|
|abstract base class|❌|✅|❌|❌|❌|
|abstract interface class|❌|❌|✅|❌|❌|
|abstract final class|❌|❌|❌|❌|❌
|mixin class|✅|✅|✅|✅|❌|
|base mixin class|✅|✅|❌|✅|❌|
|abstract mixin class|❌|✅|✅|✅|❌|
|abstract base mixin class|❌|✅|❌|✅|❌|
|mixin|❌|❌|✅|✅|❌|
|base mixin|❌|❌|❌|✅|❌|
