# Dart 언어 마스터 하기
## 3. 다트 비동기 프로그래밍
### 3.1 동기 VS 비동기 프로그래밍
#### 동기
- 한 작업이 완료된 후에 다음 작업을 시작하는 방식
- 장점 : 코드 작성 및 이해가 간단, 작업 순서를 명확하게 제어할 수 있다
- 단점 : 응답속도가 느릴 수 있다. 자원을 효율적으로 사용하지 못할 수 있다.
#### 비동기
- 여러 작업을 동시에 시작하고 작업이 완료될 떄마다 결과를 처리하는 방식
- 장점 : 응답 속도가 빠름, 자원을 효율적으로 사용할 수 있다.
- 단점 : 코드 작성 및 이해가 복잡, 작업 순서를 제어하기 어려울 수 있다.
### 3.2 Future
1. `Future` : List 나 Set 처럼 제네릭으로 어떤 미래의 값을 받아올지 정할 수 있는 클래스.
    ```dart
    void main(){
        Future<String> name;    // 미래에 받을 String값
        Future<int> number;     // 미래에 받을 int값
        Future<bool> isOpened;  // 미래에 받을 boolean값
    }
    ```
2. `Future.delayed()` : 비동기 연산, 일정 시간 후에 콜백 함수를 실행할 수 있음.
    ```dart
    void main(){
        addNumbers(1, 1);
    }

    void addNumbers(int number1, int number2){
        print('$number1 + $number2 계산 시작!');                    //실행순서 1
 
        Future.delayed(Duration(seconds: 3), (){
            print('$number1 + $number2 = ${number1 + number2}');   //실행순서 3
        });

        print('$number1 + $number2 코드 실행 끝');                  //실행순서 2
    }
    ```
### 3.3 async와 await
- `async` 와 `await` 키워드를 사용하면 비동기를 유지하면서 코드 가독성을 높일 수 있다.
- 함수를 `async` 로 지정해주고 대기하고 싶은 비동기 함수에 `await` 를 사용한다.
- 비동기 프로그래밍을 유지하며 코드가 작성된 순서대로 실행된다.
    ```dart
    void main() {
        addNumbers(1, 1);
    }

    void addNumbers(int number1, int number2) async {
        print('$number1 + $number2 계산 시작!');                     //실행순서 1
  
        await Future.delayed(Duration(seconds: 3), (){
            print('$number1 + $number2 = ${number1 + number2}');    //실행순서 2
        });

        print('$number1 + $number2 코드 실행 끝');                   //실행순서 3
    }
    ```
- `Future.delayed()` 가 실행되며 3초 기다려야 할때 다음 함수가 실행된다.
    ```dart
    void main() {
        addNumbers(1, 1);
        addNumbers(2, 2);
    }

    void addNumbers(int number1, int number2) async {
        print('$number1 + $number2 계산 시작!');                     //실행순서 1, 2
  
        await Future.delayed(Duration(seconds: 3), (){
            print('$number1 + $number2 = ${number1 + number2}');    //실행순서 3, 5
        });

        print('$number1 + $number2 코드 실행 끝');                   //실행순서 4, 6
    }
    ```
- addNumbers 2개 함수가 순차적으로 실행되려면 async 와 await 를 추가해준다.
    ```dart
    void main() async {
        await addNumbers(1, 1);
        await addNumbers(2, 2);
    }

    Future<void> addNumbers(int number1, int number2) async {
        print('$number1 + $number2 계산 시작!');
  
        await Future.delayed(Duration(seconds: 3), (){
        print('$number1 + $number2 = ${number1 + number2}');
        });

        print('$number1 + $number2 코드 실행 끝');
    }
    ```
#### 3.3.1 결과값 받기
- `Future` 클래스를 이용하여 `async` 와 `await`를 사용한 함수에서도 결과값을 받을 수 있다.
    ```dart
    void main() async {
        final result = await addNumbers(1, 1);
        print('결괏값 $result');
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
- `Future` 는 반환값을 한 번 받아내는 비동기 프로그래밍에 사용.
- `Stream` 을 사용하면 지속적으로 값을 반환.

#### 3.4.1 Stream 기본 사용법
- `dart:async` 패키지를 import
- `StreamController` 를 `listen()` 해서 값을 지속적으로 반환.
- `Stream` 에 값을 주입할 때는 `sink.add()` 함수를 실행.
    ```dart
    import 'dart:async';

    void main() {
        final controller = StreamController(); 
        final stream = controller.stream;  

        final streamListener1 = stream.listen((val) {
            print(val);
        });

        controller.sink.add(1);
        controller.sink.add(2);
        controller.sink.add(3);
        controller.sink.add(4);
    }        
    ```
#### 3.4.2 braodcast Stream
- `Stream` 을 여러 번 `listen()` 할때 사용.
- `add()` 를 실행할 때마다 `listen()` 하는 모든 콜백 함수에 값이 주입된다.
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
  
        controller.sink.add(1);
        controller.sink.add(2);
        controller.sink.add(3);
    }     
    ```
#### 3.4.3 함수로 Stream 반환하기
- `StreamController` 대신 `Stream` 을 반환하는 함수를 사용.
- `Stream` 을 반환하는 함수는 `async*` 로 선언.
- `StreamController` 의 `add()` 처럼 `yield` 키워드를 이용해서 값 반환.
- `listen()` 함수로 콜백 함수 입력
    ```dart
    import 'dart:async';

    Stream<String> calculate(int number) async* {
        for (int i = 0; i < 5; i++) {
            yield 'i = $i';
            await Future.delayed(Duration(seconds: 1));
        }
    }

    void playStream() {
        calculate(1).listen((val) {
            print(val);
        });
    }

    void main() {
        playStream();
    }      
    ```
## 4. 다트 3.0 신규 문법
### 4.1 레코드
- 다트 3.0 이상부터 사용할 수 있는 새로운 타입.
#### 4.1.1 포지셔널 파라미터를 이용한 레코드
- 여러 필드를 가진 구조를 정의하는데 사용.
    ```dart
    void main() {
        (String, int) minji = ('민지', 20);
  
        print(minji);
    }     
    ```
- 정의한 순서대로 타입을 입력하지 않으면 에러 발생.
    ```dart
    void main() {
        // Invalid Assignment 에러
        (String, int) minji = (20, '민지');
        print(minji);
    }    
    ```
- 두 개 이상의 값을 조합 가능.
    ```dart
    void main() {
        (String, int, bool) minji = ('민지', 20, true);
        print(minji);
    }    
    ```
- 특정 순서의 레코드 값을 가져올때는 '$' 사용.
    ```dart
    void main() {
        (String, int, bool) minji = ('민지', 20, true);
        print(minji.$1);
        print(minji.$2);
        print(minji.$3);
    }    
    ```    
#### 4.1.2 네임드 파라미터를 이용한 레코드
- 소괄호에 중괄호를 중첩하여 타입과 변수를 명시.
    ```dart
    void main() {  
        ({String name, int age}) minji = (name: '민지', age: 20);  
        print(minji);
    }   
    ```   
### 4.2 구조 분해
- 반환된 타입을 복제해서 타입 내부에 각각의 값을 직접 추출해오는 문법.
#### 4.2.1 리스트에서의 구조 분해 사용 예제
- 
    ```dart
    void main() {
        // 아래 코드와 같지만 한줄에 해결 할 수 있다.
        // final newJeans = ['민지', '해린'];
        // final minji = newJeans[0];
        // final haerin = newJeans[1];
        final [minji, haerin] = ['민지', '해린'];

        print(minji);  
        print(haerin);
    }    
    ```
#### 4.2.2 리스트에서의 스프레드 연산자를 이용한 구조 분해 사용 예제
- 스프레드 연산자를 사용하게 되면 중간의 값들을 버릴 수 있다.
    ```dart
    void main() {
        final numbers = [1, 2, 3, 4, 5, 6, 7, 8];
        final [x, y, ..., z] = numbers;
        
        print(x);
        print(y);
        print(z);

        print("*************************"); 
        print(numbers[0]);
        final [a, b, ..., c] = [1, 2, 3, 4, 5, 6, 7, 8];
        print(a);
    }
    ```
#### 4.2.3 맵에서의 구조 분해 사용 예제
- 맵의 구조와 똑같은 구조로 구조 분해한다.
    ```dart
    void main() {
        final minjiMap = {'name': '민지', 'age': 19};  
        final {'name': name, 'age': age} = minjiMap;
  
        print('name: $name');
        print('age: $age');
    }
    ```
#### 4.2.4 클래스에서의 구조 분해 사용 예제
- 클래스의 생성자 구조와 똑같이 구조 분해한다.
    ```dart
    void main() {
        final minJiIdol = Idol(name: '민지', age: 19);
        final Idol(name: name3, age: age3) = minJiIdol;

        print(name3);
        print(age3);
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
- switch 표현식
- 패턴 매칭
- 완전 확인
- 가드 절
#### 4.3.1 표현식 기능
- switch 문을 함수처럼 사용하여 직접 값을 반환 받을 수 있다.
- `=>` 를 사용하면 switch 문 조건에 맞을 때 값을 반환한다. 
- `_` 는 default 와 같은 의미로 사용.
    ```dart
    void main() {
        String dayKor = '월요일';
        String dayEnglish = switch (dayKor) {
            '월요일' => 'Monday',
            '화요일' => 'Tuesday',
            '수요일' => 'Wednesday',
            '목요일' => 'Thursday',
            '금요일' => 'Friday',
            '토요일' => 'Saturday',
            '일요일' => 'Sunday',
            _ => 'Not Found',
        };

        print(dayEnglish);
    }       
    ```
#### 4.3.2 패턴 매칭
- 
    ```dart
    void switcher(dynamic anything) {
        switch (anything) {
            case 'aaa':
                print('match: aaa');
                break;
            case [1, 2]:
                print('match: [1, 2]');
                break;
            case [_, _, _]:
                print('match [_,_,_]');
                break;
            case [int a, int b]:
                print('match: [int $a, int $b]');
                break;
            case (String a, int b):
                print('match: (String: $a, int: $b)');
                break;
            default:
                print('no match');
        }
    }

    void main() {
        switcher('aaa');
        switcher([1, 2]);
        switcher([3, 4, 5]);
        switcher([6, 7]);
        switcher(('민지', 19));
        switcher(8);
    }    
    ```
#### 4.3.3 엄격한 검사
- 다트 3.0 에서는 switch 문에서 모든 조건을 확인하고 있는지 빌드할 때 확인.
    ```dart
    void main(){
        bool? val;

        switch(val){
            case true:
                print('true');
            case false:
                print('false');
            /*  
            case null:
                print('null');
            default:
                print('dafault');
            */    
        };
    }
    ```
#### 4.3.4 보호 구문
- `when` 키워드로 보호 구문을 추가할 수 있다.
- `when` 키워드는 boolean 으로 반환할 조건을 각 case 문에 추가할 수 있다.
    ```dart
    void main() {
        (int a, int b) val = (1, -1);

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
- `base`, `final`, `interface`, `sealed`, `mixin`
- 모든 클래스 제한자는 class 키워드 앞에 명시한다.
- 명시한 클래스는 다른 파일에서 선언해야 정상으로 기능이 동작한다.
#### 4.4.1 base 제한자
- 클래스의 기능을 강제하는 제한자.
- 해당 클래스는 상속만 가능, 외부에서 직접 구현 불가.
- 자식 클래스는 꼭 `base`, `final`, `sealed` 중 하나의 제한자와 함께 사용해야 한다.
  - class_modifiers.dart
    ```dart
    base class Parent {
        void say() {
            print('Parent say');
        }
    }    
    ```
  - main.dart
    ```dart
    import 'class_modifiers.dart';

    void main() {
        child1.say();

        Child2 child2 = Child2();
        child2.say();
    }

    Parent child1 = Parent();

    base class Child2 extends Parent {}
    //class Child3 extends Parent {}        //제한자 없이 상속 불가
    //class Child4 implements Parent {}     //재정의 불가
    ```  
#### 4.4.2 final 제한자
- 같은 파일에서 상속과 재정의 가능.
- 외부 파일에서 해당 클래스의 상속과 구현 모두 불가.
  - class_modifiers.dart
    ```dart
    final class Parent {
        void say() {
            print('Parent say');
        }
    }

    base class Child2 extends Parent {}

    base class Child3 implements Parent {
        @override
        void say() {
            print('Child3 say');
        }
    }    
    ```
  - main.dart
    ```dart
    import 'class_modifiers.dart';

    void main() {
        child1.say();
    }

    Parent child1 = Parent();
    
    //class Child2 extends Parent {}        //상속 불가
    //class Child3 implements Parent {}     //재정의 불가
    ```
#### 4.4.3 interface 제한자
- 외부 파일에서 해당 클래스의 상속 불가, 재정의 가능.
  - class_modifiers.dart
    ```dart
    interface class Parent {
        void say() {
        print('Parent say');
        }
    }  
    ```
  - main.dart
    ```dart
    import 'class_modifiers.dart';

    void main() {
        child1.say();

        Child3 child3 = Child3();
        child3.say();
    }

    Parent child1 = Parent();

    //class Child2 extends Parent {}        //상속 불가
    class Child3 implements Parent {
        @override
        void say() {
            print('Child say');
        }
    } 
    ```
#### 4.4.4 sealed 제한자
- 외부 파일에서 해당 클래스를 상속, 재정의, 인스턴스화 불가.
  - class_modifiers.dart
    ```dart
    sealed class Parent {} 
    ```
  - main.dart
    ```dart
    import 'class_modifiers.dart';

    void main() {}
    
    //Parent child1 = Parent();             //인스턴스 불가

    //class Child2 extends Parent {}        //상속 불가

    //class Child3 implements Parent {}     //재정의 불가
    ```
#### 4.4.5 mixin 제한자
- 다트 3.0 부터 클래스에 mixin 사용 가능.
  - main.dart
    ```dart
    void main() {
        Child1 child1 = Child1();
        child1.say();

        Child2 child2 = Child2();
        child2.say();
    }

    mixin class MixinExample {
        void say() {
            print('child say');
        }
    }

    class Child1 extends MixinExample {}

    class Child2 with MixinExample {}
    ```


