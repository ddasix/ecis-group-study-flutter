# 단계 1 - 다트 언어 마스터하기
## ch01 다트 입문하기
### 1.1 다트 소개
구글이 개발한 다트 프로그래밍 언어는 2011년 10월 GOTO 콘퍼런스에서 처음 공개  

크롬에 다트 가상 머신을 심어 자바스크립트를 대체하려는 시도를 했지만,  
웹 개발에 혼란을 가져온다는 여론을 극복하지 못하고 다트 언어를 자바스크립트로 완전 컴파일 하는데만 그침  

다트 언어는 웹에서 자바스크립트를 대체하진 못했지만 현재 플러터의 인기에 모바일 영역에서 큰 각광을 받고 있음

- 다트의 장점과 특징
  - UI<sup>UserInterface</sup> 제작 최적화
  - 완전한 비동기 언어
  - 이벤트 기반
  - 아이솔레이트<sup>Isolate</sup> 를 이용한 동시성 기능 제공
  - 널 안정성<sup>Null Safety</sup>, 스프레드 기능<sup>Spread Operator</sup>, 컬렉션 if문<sup>Collection If</sup> 등 의 기능 제공  
  - 핫 리로드<sup>Hot reload</sup> 기능(개발 중간에 즉시 변경사항 확인)
  - 멀티 플랫폼에서 로깅 및 디버깅 지원
  - AOT 컴퍼일로 인한 모든 플랫폼에서의 빠른 속도
  - 효율성을 위해 개발할 때는 JIT<sup>Just In Time</sup> 방식, 배포할 때는 AOT<sup>Ahead of Time</sup> 방식 적용
  - 자바스크립트로의 완전한 컴파일
  - 백엔드 프로그래밍 지원

※ 교재를 참고할 때 도움이 되기 위해  
중간에 불필요한 넘버링은 건너뛰고 섹션넘버링을 교재와 동일하게 유지하여 작성함

### 1.3 기초 문법
손쉽고 빠르게 코드를 실행해 볼 수 있는 DartPad 사이트  
https://dartpad.dev/  

1.3.1 메인함수
```dart
void main() {

}
```
1.3.2 주석
```dart
void main() {
    // 한 줄 주석

    /* 여러 줄 주석 (시작기호: /*, 끝나는 기호: */)
    * 필수는 아니지만 관행상 중간 줄의 시작으로 *를 사용
    */

    /// 문서 주석
    DartDoc나 Android Studio 같은 IDE에서 문서(Documentation)로 인식함
}
```
1.3.3 print() 함수
```dart
void main() {
  // 콘솔에 출력
  print('Hello World');
}
```
1.3.4 var를 사용한 변수 선언
```dart
void main() {
  var name = '코드팩토리';
  print(name);

  // 변숫값 변경 가능
  name = '골든래빗';
  print(name);

  // 변수명 중복은 불가능
  // 그래서 다음 코드에서 주석을 제거하면 코드에서 에러 발생
  // var name = '이정우';
}
```
1.3.5 dynamic을 사용한 변수 선언
```dart
void main() {
  dynamic name = '코드팩토리';
  name = 1;
}
- var는 타입이 한번 유추되면 고정이 되지만, dynamic은 변수의 타입이 고정되지 않아 변경 가능
```
1.3.6 final/const를 사용한 변수 선언
```dart
void main() {
  final String name = '블랙핑크';
  name = 'BTS'; // 에러 발생, final로 선언한 변수는 선언 후 값을 변경할 수 없음

  const String name2 = 'BTS';
  name2 = '블랙핑크'; // 에러 발생, const로 선언한 변수는 선언 후 값을 변경할 수 없음
}
```
- final과 const의 차이점
  - final은 런타임 상수(실행 시점에 변수에 할당됨)
  - const는 빌드 타임 상수(빌드 시점에 변수에 할당됨)  
    - final과 const 예시
      ```dart
      // final 상수 적용 예시(정상동작)
      void main() {
        final DateTime now = DateTime.now();

        print(now);
      }

      /* 
      * DateTime now() 함수는 DateTime.now() 함수가 실행되는 순간의 날짜 및 시간을 제공함
      * 따라서 실행을 해봐야 값을 알 수 있으며 에러가 나지 않음
      */
      ```
      ```dart
      // const 상수 적용 예시(에러발생)
      void main() {
        const DateTime now = Datetime.now();

        print(now);
      }

      /*
      * const로 지정한 변수는 빌드 타임에 값을 알 수 있어야 하는데 DateTime.now() 함수는 런타임에 반환되는 값을 알 수 있기 때문에 에러가 발생함
      */
      ```
1.3.7 변수 타입
```dart
void main() {
  // String - 문자열
  String name = '코드팩토리';

  // int - 정수
  int isInt = 10;

  // double - 실수
  double isDouble = 2.5;

  // bool - 불리언 (true/false)
  bool isTrue = true;
  print(name);
  print(isInt);
  print(isDouble);
  print(isTrue);
}
```
### 1.4 컬렉션
1.4.1 List 타입
```dart
void main() {
  // 리스트에 넣을 타입을 <> 사이에 명시할 수 있음
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  print(blackPinkList);
  print(blackPinkList[0]);  // 첫 원소 지정
  print(blackPinkList[3]);  // 마지막 원소 지정

  print(blackPinkList.length);  // 길이 반환

  blackPinkList[3] = '코드팩토리';  // 3번 인덱스값 변경
  print(blackPinkList);
}
```
- add() 함수
  ```dart
  void main() {
    List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

    blackPinkList.add('코드팩토리');  // 리스트의 끝에 추가

    print(blackPinkList);
  }
  ```
- where() 함수  
  - List를 순회<sup>looping</sup>하면서 특정조건 필터링  
  - 순회 후 이터러블<sup>Iterable</sup> 반환
  ```dart
  void main() {
    List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

    final newList = blackPinkList.where(
      (name) => name == '리사' || name == '지수',  // '리사' 또는 '지수'만 유지
    );

    print(newList);
    print(newList.toList());  // Iterable을 List로 다시 변환할 때 .toList() 사용
  }
  ```
- map() 함수
  - 순회 후 이터러블<sup>Iterable</sup> 반환
  ```dart
  void main() {
    List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

    final newBlackPink = blackPinkList.map(
      (name) => '블랭핑크 $name', // 리스트의 모든 값 앞에 '블랭핑크' 추가
    );
    print(newBlackPink);

    // Iterable을 List로 다시 반환하고 싶을 때 .toList() 사용
    print(newBlackPink.toList());
  }
  ```
- reduce() 함수
  - 초기값 value = 리스트의 첫 번째 값
  - 순회할 때 마다 값을 쌓아가는 특징 (fold() 함수와 동일)
  - 순회 후 List 요소들의 타입과 같은 리스트 타입을 반환 (예: Stirng => String, int => int)
  ```dart
  void main() {
    List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

    final allMembers = blackPinkList.reduce((value, element) => value + ', ' + element);

    print(allMembers);
  }
  ```
- fold() 함수
  - 초기값 value = 0
  - 순회할 때 마다 값을 쌓아가는 특징 (reduce() 함수와 동일)
  - 순회 후 List 요소들의 타입과는 상관없이 어떤 타입이든 반환가능 (예: String => int, int => String)
  ```dart
  void main() {
    List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

    // reduce() 함수와 마찬가지로 각 요소를 순회하며 실행
    final allMembers = blackPinkList.fold<int>(0, (value, element) => value + element.length);

    print(allMembers);
  }
  ```
1.4.2 Map 타입
```dart
void main() {
  Map<String, String> dictionary = {
    'Harry Potter': '해리 포터',        // 키 : 값
    'Ron Weasley': '론 위즐리',
    'Hermione Granger': '헤르미온느 그레인저',
  };
  print(dictionary['Harry Potter']);
  print(dictionary['Hermione Granger']);

  // 키와 값 반환
  print(dictionary.keys);
  print(dictionary.values);

  // Iterable이 반환되기 때문에 추가적으로 .toList()를 실행해서 List도 반환가능
  print(dictionary.keys.toList());
  print(dictionary.values.toList());
}
```
1.4.3 Set 타입
  - 중복을 허용하지 않음
  - .toList() => 기존 데이터를 유지한 채 List 타입으로 변환가능
  - keys.toList(), values.toList() => Map 타입의 키와 값을 List로 반환
  - Set.from() => 어떤 리스트든 Set 타입으로 변환가능(Set의 특성상 변환시 중복값 제거)
```dart
void main() {
  Set<String> blackPink = {'로제', '지수', '리사', '제니', '제니'}; // 제니 중복

  print(blackPink);
  print(blackPink.contains('로제'));  // 값이 있는지 확인하기
  print(blackPink.toList());          // 리스트로 변환하기

  List<String> blackPink2 = ['로제', '지수', '지수'];
  print(Set.from(blackPink2));  // List 타입을 Set 타입으로 변환
}
```
1.4.4 enum
```dart
enum Status {
  approved,
  pending,
  rejected,
}
void main() {
  Status status = Status.approved;
  print(status);  // Status.approved
}
```
### 1.5 연산자
1.5.1 기본 수치 연산자
```dart
void main() {
  double number = 2;

  print(number + 2); // 4 출력
  print(number - 2); // 0 출력
  print(number * 2); // 4 출력
  print(number / 2); // 1 출력, 나눈 몫
  print(number % 3); // 2 출력, 나눈 나머지
  
  // 단항 연산도 가능
  number++; // 3
  number--; // 2
  number += 2; // 4
  number -= 2; // 0
  number *= 2; // 4
  number /= 2; // 1
}
```
1.5.2 null 관련 연산자
```dart
void main() {
  // 타입 뒤에 ?를 명시해서 null값 가능
    double? number1 = 1;

  // 타입 뒤에 ?를 명시하지 않으면 에러 발생
    double number2 = null;
}
```
```dart
void main() {
  double? number; // 자동으로 null값 지정
  print(number);

  number ??= 3;   // ??를 사용하면 기존 값이 null일 때만 저장됨
  print(number);

  number ?? =4;   // null이 아니므로 3이 유지됨(이전단계에서 number에 3이 저장됨)
  print(number);
}
```
1.5.3 값 비교 연산자
```dart
void main() {
  int number1 = 1;
  int number2 = 2;

  print(number1 > number2);  // false
  print(number1 < number2);  // true
  print(number1 >= number2); // false
  print(number1 <= number2); // true
  print(number1 == number2); // false
  print(number1 != number2); // true
}
```
1.5.4 타입 비교 연산자
```dart
void main() {
  int number1 = 1;

  print(number1 is int);      // true
  print(number1 is String);   // false
  print(number1 is! int);     // false. !는 반대를 의미합니다(int 타입이 아닌 경우 true).
  print(number1 is! String);  // true
}
```
1.5.5 논리 연산자
```dart
void main() {
  bool result = 12 > 10 && 1 > 0; // 12가 10보다 크고 1이 0보다 클 때
  print(result);  // true

  bool result2 = 12 > 10 && 0 > 1; // 12가 10보다 크고 0이 1보다 클 때
  print(result2); // false

  bool result3 = 12 > 10 || 1 > 0; // 12가 10보다 크거나 1이 0보다 클 때
  print(result3); // true

  bool result4 = 12 > 10 || 0 > 1; // 12가 10보다 크거나 0이 1보다 클 때
  print(result4); // true

  bool result5 = 12 < 10 || 0 > 1; // 12가 10보다 작거나 0이 1보다 클 때
  print(result5); // false
}
```
### 1.6 제어문
1.6.1 if문
```dart
void main() {
  int number = 2;

  if (number % 3 == 0) {
    print('3의 배수');
  } else if (number % 3 == 1) {
    print('나머지가 1');
  } else {
    // 조건에 맞지 않기 때문에 다음 코드 실행
    print('맞는 조건이 없음');
  }
}
```
1.6.2 switch문
```dart
enum Status {
  approved,
  pending,
  rejected,
}

void main() {
  Status status = Status.approved;

  switch (status) {
    case Status.approved:
    // approved 값이기 때문에 다음 코드가 실행
      print('승인 상태');
      break;
    case Status.pending:
      print('대기 상태');
      break;
    case Status.rejected:
      print('거절 상태');
      break;
    default:
      print('알 수 없는 상태');
  }

  // Enum의 values값은 Enum의 모든 수를 리스트로 반환함
  print(Status.values);
}
```
1.6.3 for문
```dart
void main() {
  // 값 선언; 조건 설정; loop 마다 실행할 기능
  for (int i = 0; i < 3; i++) {
    print(i);
  }
}
```
- 다트 언어에서는 for in 패턴의 for문 제공 (List의 모든 값을 순회하고 싶을 때 사용)
  ```dart
  void main() {
    int total = 0;
  
    List<int> numberList = [3, 6, 9];
  
    for (int number in numberList) {
      print(number);
    }
  }
  ```
1.6.4 while문과 do...while문  
- while문 (조건 확인 후 true가 반환되면 반복문 실행)
  ```dart
  void main(){
    int total = 0;

    while(total < 10){  // total 값이 10보다 작으면 계속 실행
      total += 1;
    }

    print(total);
  }
  ```
- do...while문 (반복문 실행 후 조건 확인)
  ```dart
  void main(){
    int total = 0;

    do {
      total += 1;
    } while(total < 10);

    print(total);
  }
  ```
### 1.7 함수와 람다
1.7.1 함수의 일반적인 특징
- 순서가 고정된 매개변수 (포지셔널 파라미터<sup>positional parameter</sup>, 위치 매개변수)  
  - 입력된 순서대로 매개변수에 값이 지정됨
  ```dart
  int addTwoNumbers(int a, int b) {
    return a + b;
  }
  
  void main() {
    print(addTwoNumbers(1, 2));
  } 
  ```
- 이름이 있는 매개변수 (네임드 파라미터<sup>named parameter</sup>, 명명된 매개변수)
  - 순서와 관계없이 지정하고 싶은 매개변수의 이름을 이용해 값 입력가능
  - 네임드 파라미터를 지정하려면 중괄호 {} 와 required 키워드를 사용해야함
  ```dart
  int addTwoNumbers({
    required int a,
    required int b,
  }) {
    return a + b;
  }

  void main() {
    print(addTwoNumbers(a: 1, b: 2));
  }
  ```
- 기본값을 갖는 포지셔널 파라미터 지정 ( [ ] 기호 사용 )
  ```dart
  int addTwoNumbers(int a, [int b = 2]) {
    return a + b;
  }
  void main() {
    print(addTwoNumbers(1));
  }
  ```
- 네임드 파라미터에 기본값 적용
  - required 키워드 생략 후 등호 다음에 원하는 기본값 입력
  ```dart
  int addTwoNumbers({
  required int a,
  int b = 2, (required 생략)
  }) {
    return a + b;
  }
  
  void main() {
    print(addTwoNumbers(a: 1)); (원하는 기본값 입력)
  }
  ```
- 포지셔널 파라미터와 네임드 파라미터를 섞어서 사용가능
  - 단, 포지셔널 파라미터가 네임드 파리미터보다 반드시 먼저 위치해야함
  ```dart
  int addTwoNumbers(
    int a, {
      required int b,
      int c = 4,
    }) {
  return a + b + c;
  }

  void main() {
    print(addTwoNumbers(1, b: 3, c: 7));
  }
  ```
1.7.2 익명 함수와 람다 함수  
- 특징
  ```dart
  함수 이름이 없고 일회성으로 사용된다는 공통점  
  다트 언어에서는 이 둘을 구분하지 않음
  ```
- 익명 함수와 람다 함수 표현 방식
  ```dart
  // 익명 함수 표현 방식
  (매개변수) {
    함수 바디
  }

  // 람다 함수 표현 방식
  (매개변수 => 단 하나의 스테이트먼트) 
  ```
- 익명 함수
  ```dart
  void main() {
    List<int> numbers = [1,2,3,4,5];

    // 일반 함수로 모든 값 더하기
    final allMembers = numbers.reduce((value, element) {
      return value + element;
    });

    print(allMembers);
  }
  ```
- 람다 함수
  ```dart
  void main() {
    List<int> numbers = [1,2,3,4,5];

    // 람다 함수로 모든 값 더하기
    final allMembers = numbers.reduce((value, element) => value + element);

    print(allMembers);
  }
  ```
1.7.3 typedef와 함수
- typedef 키워드는 함수의 시그니처를 정의하는 값
- 여기서 시그니처는 반환값 타입, 매개변수 개수와 타입 등을 일컫음
- 즉, 함수 선언부를 정의하는 키워드
- 함수가 무슨 동작을 하는지에 대한 정의는 없음
```dart
typedef Operation = void Function(int x, int y);
```
- typedef를 사용하여 생성한 위의 함수를 사용하는 예시
  - 시그니처에 맞춘 함수를 만들어서 사용함
  ```dart
  typedef Operation = void Function(int x, int y);

  void add(int x, int y) {
    print('결괏값 : ${x + y}');
  }

  void subtract(int x, int y) {
    print('결괏값 : ${x - y}');
  }

  void main() {
    // typedef는 일반적인 변수의 type처럼 사용 가능
    Operation oper = add;
    oper(1, 2);

    // subtract() 함수도 Operation에 해당되는
    // 시그니처이므로 oper 변수에 저장 가능
    oper = subtract;
    oper(1, 2);
  }
  ```
- 다트에서 함수는 일급 객체<sup>first-class-citizen</sup>이므로 함수를 값처럼 사용 가능
  ```dart
  typedef Operation = void Function(int x, int y);

  void add(int x, int y) {
    print('결괏값 : ${x + y}');
  }

  void calculate(int x, int y, Operation oper) {
    oper(x, y);
  }

  void main() {
    calculate(1, 2, add); // calculate() 함수의 3번째 매개변수로 add() 함수 입력함
  }
  ```
### 1.8 try...catch
- 정상적인 로직
  ```dart
  void main() {
    try{

      // 에러가 없을 때 실행할 로직
      final String name = '코드팩토리';

      print(name);  // 에러가 없으니 출력됨
    }catch(e){      // catch는 첫 번째 매개변수에 에러 정보를 전달함

      // 에러가 있을 때 실행할 로직
      print(e);
    }
  }
  ```
- throw 키워드를 사용한 에러 발생 로직
  ```dart
  void main() {
    try{
      final String name = '코드팩토리';

      // throw 키워드로 고의적으로 에러를 발생시킴
      throw Exception('이름이 다름');

      print(name);
    }catch(e){

      // try에서 에러가 발생했으니 catch 로직이 실행됨
      print(e);
    }
  }
  ```
## ch02 다트 객체지향 프로그래밍
### 2.1 객체지향 프로그래밍의 필요성
- 수천 줄에서 수만 줄의 모든 코드를 main() 함수에서 작성하면 코드 정리가 안 돼 유지보수 및 협업에 문제가 발생함
- 객체지향 프로그래핑을 하면 변수와 메서드를 특정 클래스에 종속되게 코딩할 수 있음
- 클래스를 사용해서 서로 밀접한 관계가 있는 함수와 변수를 묶어두면 코드 관리가 용이함
- 클래스는 일종의 설계도로서 데이터가 보유할 속성과 기능을 정의하는 자료구조임
- 인스턴스는 클래스를 기반으로 만들어진 객체
- 인스턴스화는 클래스에서 인스턴스(객체)를 생성하는 과정을 뜻하며 인스턴스화가 진행되어야 실물이 존재
### 2.2 객체지향 프로그래밍의 시작, 클래스
```dart
// class 키워드를 입력 후 클래스명을 지정해 클래스를 선언함
class Idol {
  // 클래스에 종속되는 변수를 지정할 수 있음
  String name = '블랙핑크';

  // 클래스에 종속되는 함수를 지정할 수 있음
  // 클래스에 종속되는 함수를 메서드라고 통칭함
  void sayName() {

    // 클래스 내부의 속성을 지칭하고 싶을 때는 this 키워드를 사용
    // 결과적으로 this.name은 Idol 클래스의 name 변수를 지칭함
    print('저는 ${this.name}입니다.');
    // 스코프 안에 같은 속성 이름이 하나만 존재한다면 this를 생략할 수 있음
    print('저는 $name입니다.');
  }
}

void main() {
  // 변수 타입을 Idol로 지정하고
  // Idol의 인스턴스를 생성할 수 있음
  // 인스턴스를 생성할 때는 함수를 실행하는 것처럼
  // 인스턴스화하고 싶은 클래스에 괄호를 열고 닫아줌
  Idol blackPink = Idol();  // Idol 인스턴스 생성완료

  // 메서드를 실행
  blackPink.sayName();
}
```
2.2.1 생성자
```dart
class Idol {
  // 생성자에서 입력받는 변수들은 일반적으로 final 키워드 사용
  final String name;

  // 생성자 선언
  // 클래스와 같은 이름이어야 함
  // 함수의 매개변수를 선언하는 것처럼 매개변수를 지정해줌
  Idol(String name) : this.name = name;

  void sayName() {
    print('저는 ${this.name}입니다.');
  }
}

void main() {
  // name에 '블랙핑크' 저장
  Idol blackPink = Idol('블랙핑크');
  blackPink.sayName();

  // name에 'BTS' 저장
  Idol bts = Idol('BTS');
  bts.sayName();
}

// 생성자의 매개변수를 변수에 저장하는 과정을 생략하는 방법
class Idol {
  final String name;

  // this를 사용할 경우
  // 해당되는 변수에 자동으로 매개변수가 저장됨.
  Idol(this.name);

  void sayName() {
    print('저는 ${this.name}입니다.');
  }
}
```
2.2.3 네임드 생성자
```dart
class Idol {
  final String name;
  final int membersCount;

  // 생성자
  Idol(String name, int membersCount)
  // 1개 이상의 변수를 저장하고 싶을 때는 , 기호로 연결해주면 됨
      : this.name = name,
        this.membersCount = membersCount;

  // 네임드 생성자
  // {클래스명.네임드 생성자명} 형식
  // 나머지 과정은 기본 생성자와 같음
  Idol.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.membersCount = map['membersCount'];

  void sayName() {
    print('저는 ${this.name}입니다. ${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

void main() {
  // 기본 생성자 사용
  Idol blackPink = Idol('블랙핑크', 4);
  blackPink.sayName();

  // fromMap이라는 네임드 생성자 사용
  Idol bts = Idol.fromMap({
    'name': 'BTS',
    'membersCount': 7,
  });
  bts.sayName();
}
```
2.2.3 프라이빗 변수
```dart
class Idol {
  // '_'로 변수명을 시작하면
  // 프라이빗 변수를 선언할 수 있음
  String _name;

  Idol(this._name);
}

void main() {
  Idol blackPink = Idol('블랙핑크');

  // 같은 파일에서는 _name 변수에 접근할 수 있음
  // 다른 파일에서는 _name 변수에 접근할 수 없음
  print(blackPink._name);
}
```
2.2.4 게터/세터
- 어떤 값의 노출여부와 노출 시 형태, 어떤 변수를 변경 가능하게 할지 유연하게 정할 수 있음
- 최근에는 객체지향 프로그래밍을 할 때 변수의 불변성<sup>Immutable</sup>을 특성으로 사용하기 때문에 세터는 거의 사용하지 않음(게터는 종종 사용함)
```dart
class Idol {
  String _name= '블랙핑크' ;

  // get 키워드를 사용해서 게터임을 명시함
  // 게터는 메서드와 다르게 매개변수를 전혀 받지 않음
  String get name {
    return this._name;
  }

  // 세터는 set이라는 키워드를 사용해서 선언함
  // 세터는 매개변수로 딱 하나의 변수를 받을 수 있음
  set name(String name) {
    this._name = name;
  }
}

void main() {
  Idol blackPink = Idol();

  blackPink.name = '에이핑크'; // 세터
  print(blackPink.name);      // 게터
}
```
### 2.3 상속
```dart
class Idol {
  final String name;
  final int membersCount;

  Idol(this.name, this.membersCount);

  void sayName() {
    print('저는 ${this.name}입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

// extends 키워드를 사용해서 상속받음
// class 자식 클래스 extends 부모 클래스 순서
class BoyGroup extends Idol {

  // 상속받은 생성자
  BoyGroup(
      String name,
      int membersCount,
      ) :  super(   // super는 부모 클래스를 지칭함
    name,
    membersCount,
  );

  // 상속받지 않은 기능
  void sayMale() {
    print('저는 남자 아이돌입니다.');
  }
}

void main() {

  BoyGroup bts = BoyGroup('BTS', 7);  // 생성자로 객체 생성

  bts.sayName();          // 부모한테 물려받은 메서드
  bts.sayMembersCount();  // 부모한테 물려받은 메서드
  bts.sayMale();          // 자식이 새로 추가한 메서드
}
```
### 2.4 오버라이드
```dart
class GirlGroup extends Idol {
  // 2.3 상속에서처럼 super 키워드를 사용해도 되고 다음처럼 생성자의 매개변수로 직접 super 키워드 사용가능
  GirlGroup(
      super.name,
      super.membersCount,
      );

  // override 키워드를 사용해 오버라이드함
  @override
  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다.');
  }
}

void main() {
  GirlGroup redVelvet = GirlGroup('블랙핑크', 4);

  redVelvet.sayName(); // 자식 클래스의 오버라이드된 메서드 사용

  // sayMembersCount는 오버라이드하지 않았기 때문에
  // 그대로 Idol 클래스의 메서드가 실행됨
  redVelvet.sayMembersCount(); // 부모 클래스의 메서드 사용
}
```
### 2.5 인터페이스
- 다트에는 인터페이스를 지정하는 키워드가 없음
- 상속은 단 하나의 클래스만 할 수 있지만 인터페이스는 적용 개수에 제한이 없음(', ' 기호를 사용하여 나열 가능)
- 상속은 재정의가 필요없지만 인터페이스 특성상 반드시 모든 기능을 재정의 해줘야 함
```dart
// implements 키워드를 사용하면 원하는 클래스를 인터페이스로 사용할 수 있음
class GirlGroup implements Idol {
  final String name;
  final int membersCount;

  GirlGroup(
      this.name,
      this.membersCount,
      );

  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

void main() {
  GirlGroup redVelvet = GirlGroup('블랙핑크', 4);

  redVelvet.sayName();
  redVelvet.sayMembersCount();
}
```
### 2.6 믹스인
- 특정 클래스에 원하는 기능들만 골라 넣을 수 있는 기능
- 특정 클래스를 지정해서 속성들을 정의할 수 있으며 지정한 클래스를 상속하는 클래스에서도 사용할 수 있음
- 인터페이스처럼 한 개의 클래스에 여러 개의 믹스인을 적용할 수도 있음
- ', '기호를 사용하여 여러 믹스인 나열 가능
```dart
mixin IdolSingMixin on Idol{
  void sing(){
    print('${this.name}이 노래를 부릅니다.');
  }
}

// 믹스인을 적용할 때는 with 키워드 사용
class BoyGroup extends Idol with IdolSingMixin{
  BoyGroup(
      super.name,
      super.membersCount,
      );

  void sayMale() {
    print('저는 남자 아이돌입니다.');
  }
}

void main(){
  BoyGroup bts = BoyGroup('BTS', 7);

  // 믹스인에 정의된 sing() 함수 사용 가능
  bts.sing();
}
```
### 2.7 추상
- 추상 클래스는 인스턴스화가 필요 없는 공통 부모 클래스를 만들 때 사용
- 상속이나 인터페이스로 사용하는 데 필요한 속성만 정의하고 인스턴스화 할 수 없도록 하는 기능
- 추상 클래스는 추상 메서드를 선언만 하고 메서드 정의를 자식 클래스에게 강제 위임할 수 있음
```dart
// abstract 키워드를 사용해 추상 클래스 지정
abstract class Idol {
  final String name;
  final int membersCount;

  Idol(this.name, this.membersCount); // 생성자 선언

  void sayName();          // 추상 메서드 선언
  void sayMembersCount();  // 추상 메서드 선언
}

// implements 키워드를 사용해 추상 클래스를 구현하는 클래스
class GirlGroup implements Idol {
  final String name;
  final int membersCount;

  GirlGroup(
      this.name,
      this.membersCount,
      );

  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

void main() {
  GirlGroup blackPink = GirlGroup('블랙핑크', 4);

  blackPink.sayName();
  blackPink.sayMembersCount();
}
```
### 2.8 제네릭
- 클래스나 함수의 정의를 선언할 때가 아니라 인스턴스화하거나 실행할 때로 미루는 특징
  - 특정 변수의 타입을 하나의 타입으로 제한하고 싶지 않을 때 자주 사용함
  - 인스턴스화나 실행 전까진 어떤 타입으로 생성될지 알지 못함
- Map, List, Set 등에서 사용한 <>사이에 입력되는 값이 제네릭 문자
- 흔히 사용되는 제니릭 문자
  - T : 변수 타입을 표현할 때 흔히 사용
    - 예) T value;
  - E : 리스트 내부 요소들의 타입을 표현할 때 흔히 사용
    - 예) List<E>;
  - K : 키를 표현할 때 흔히 사용
    - 예) Map<K, V>;
  - V : 값을 표현할 때 흔히 사용
    - 예) Map<K, V>;
```dart
// 인스턴스화할 때 입력받을 타입을 T로 지정함
class Cache<T> {
  // data의 타입을 추후 입력될 T 타입으로 지정함
  final T data;

  Cache({
    required this.data,
  });
}

void main() {
  // T의 타입을 List<int>로 입력함
  final cache = Cache<List<int>>(
    data: [1,2,3],
  );

  // 제네릭에 입력된 값을통해 data 변수의 타입이 자동으로 유추됨
  // reduce() 함수가 기억나지 않는다면 1.3.1절 List타입의 reduce() 함수 복습필수
  print(cache.data.reduce((value, element) => value + element));
}
```
### 2.9 스태틱
- '스태틱 변수' 또는 '정적 변수'라고 통칭
- static 키워드를 사용하면 클래스 자체에 귀속됨
- 인스턴스끼리 공유해야 하는 정보에 지정하여 사용
```dart
class Counter{
  // static 키워드를 사용해서 static 변수 선언
  static int i= 0;


  // static 키워드를 사용해서 static 변수 선언
  Counter(){
    i++;
    print(i++);
  }
}

void main() {
  Counter count1 = Counter();
  Counter count2 = Counter();
  Counter count3 = Counter();
}
```
### 2.10 캐스케이드 연산자
- 인스턴스에서 해당 인스턴스의 속성이나 멤버 함수를 연속해서 사용하는 기능
- 캐스케이드 연산자는 '..'기호를 사용함
```dart
// 2.3 '상속'에서 사용한 Idol 클래스
class Idol {
  final String name;
  final int membersCount;

  Idol(this.name, this.membersCount);

  void sayName() {
    print('저는 ${this.name}입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명입니다.');
  }
}

void main() {
  // cascade operator (..)을 사용하면
  // 선언한 변수의 메서드를 연속으로 실행할 수 있음
  Idol blackpink= Idol('블랙핑크', 4)
    ..sayName()
    ..sayMembersCount();
}
```
