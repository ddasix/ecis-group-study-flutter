다트 패드 : https://dartpad.dev/
소스 git hub : https://github.com/codefactory-co/flutter-golden-rabbit-novice-v2

01. 다트 입문하기
1.3 기초 문법
1.3.5 dynamic을 사용한 변수 선언
- 변수의 타입을 고정하지 않고 값을 저장

void main() {
  dynamic name = '코드팩토리';
  name = 1;
}

1.3.6 final/const를 사용한 변수 선언
final : 런타임 상수
const : 빌드 타임 상수

void main() {
  final DateTime now = DateTime.now();

  print(now);
}

void main() {
  // 에러
  const DateTime now = DateTime.now();

  print(now);
}

1.4 컬렉션
1.4.1 List 타입
*List 
  // 리스트에 넣을 타입을 <> 사이에 명시할 수 있습니다.
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  print(blackPinkList);
  print(blackPinkList[0]);  // 첫 원소 지정
  print(blackPinkList[3]);  // 마지막 원소 지정

  print(blackPinkList.length);  // ❶ 길이 반환

  blackPinkList[3] = '코드팩토리';  // 3번 인덱스값 변경
  print(blackPinkList);

*add() 함수
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  blackPinkList.add('코드팩토리');  // 리스트의 끝에 추가

  print(blackPinkList);

*where() 함수
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  final newList = blackPinkList.where(
        (name) => name == '리사' || name == '지수',  // ‘리사’ 또는 ‘지수’만 유지
  );

  print(newList);
  print(newList.toList()); // Iterable을 List로 다시 변환할 때  .toList() 사용

*map() 함수
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  final newBlackPink = blackPinkList.map(
        (name) => '블랙핑크 $name',  // 리스트의 모든 값 앞에 ‘블랙핑크’를 추가
  );
  print(newBlackPink);

  // Iterable을 List로 다시 변환하고 싶을 때 .toList() 사용
  print(newBlackPink.toList());

*reduce() 함수
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  final allMembers = blackPinkList.reduce((value, element) => value + ', ' + element);  // ➊ 리스트를 순회하며 값들을 더합니다.

  print(allMembers);

*fold() 함수
  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  // ➊ reduce() 함수와 마찬가지로 각 요소를 순회하며 실행됩니다.
  final allMembers =
  blackPinkList.fold<int>(0, (value, element) => value + element.length);

  print(allMembers);

1.4.2 Map 타입
- Key, value 의 짝으로 저장
  Map<String, String> dictionary = {
    'Harry Potter': '해리 포터',        // 키 : 값
    'Ron Weasley': '론 위즐리',
    'Hermione Granger': '헤르미온느 그레인저',
  };
  print(dictionary['Harry Potter']);
  print(dictionary['Hermione Granger']);

1.4.3 Set 타입
- 중복 없는 값들의 집합
- List <-> Set 타입 변환 가능
  Set<String> blackPink = {'로제', '지수', '리사', '제니', '제니'}; // ➊ 제니 중복

  print(blackPink);
  print(blackPink.contains('로제')); // ➋ 값이 있는지 확인하기
  print(blackPink.toList());         // ➌ 리스트로 변환하기

  List<String> blackPink2 = ['로제', '지수', '지수'];
  print(Set.from(blackPink2));  // ➍ List 타입을 Set 타입으로 변환

1.5 연산자
1.5.2 null 관련 연산자
- null 은 아무 값도 없음을 뜻함. 0은 0이라는 값이 존재
- 기본적으로 null 값 저장 안됌, 타입 뒤에 ? 을 추가해야 null 저장 가능
  // 타입 뒤에 ?를 명시해서 null값을 가질 수 있습니다.
  double? number1 = 1;

  // 타입 뒤에 ?를 명시하지 않아 에러가 납니다.
  // double number2 = null;
1.5.4 타입 비교 연산자
- is 키워드 사용
  int number1 = 1;

  print(number1 is int);     // true
  print(number1 is String);  // false
  print(number1 is! int);    // false. !는 반대를 의미합니다(int 타입이 아닌 경우 true).
  print(number1 is! String); // true

1.7 함수와 람다
1.7.1 함수의 일반적인 특징
- 네임드 파라미터 지정하려면 {} 와 required 키워드 사용
int addTwoNumbers({
  required int a,
  required int b,
}) {
  return a + b;
}

void main() {
  print(addTwoNumbers(a: 1, b: 2));
}

- 네임드 파라미터 기본값 적용. required 키워드 생략하고 등호 사용
int addTwoNumbers(int a, [int b = 2]) {
  return a + b;
}
void main() {
  print(addTwoNumbers(1));
}
1.7.2 익명 함수와 람다 함수
- 익명 함수에서 {} 를 빼고 => 기호를 추가하면 람다 함수
1.7.3 typedef 와 함수
- typedef 키워드는 함수의 시그니처를 정의
1.8 try catch

02. 다트 객체지향 프로그래밍
2.1 객체지향 프로그래밍의 필요성
2.2 객체지향 프로그래밍의 시작, 클래스
2.2.1 생성자
- 매개변수 방식
class Idol {
  // ❶ 생성자에서 입력받는 변수들은 일반적으로 final 키워드 사용
  final String name;

  // ❷ 생성자 선언
  // 클래스와 같은 이름이어야 합니다.
  // 함수의 매개변수를 선언하는 것처럼 매개변수를 지정해줍니다.
  Idol(String name) : this.name = name;

  void sayName() {
    print('저는 ${this.name}입니다.');
  }
}
2.2.2 네임드 생성자
Idol.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.membersCount = map['membersCount'];
2.2.3 프라이빗 변수
- 다트에서는 같은 파일에서만 접근 가능
- 변수명을 _ 기호로 시작
2.2.4 getter/setter
class Idol {
  String _name= '블랙핑크' ;

  // ❶ get 키워드를 사용해서 게터임을 명시합니다.
  // 게터는 메서드와 다르게 매개변수를 전혀 받지 않는다.
  String get name {
    return this._name;
  }

  // ❷ 세터는 set이라는 키워드를 사용해서 선언합니다.
  // 세터는 매개변수로 딱 하나의 변수를 받을 수 있습니다.
  set name(String name) {
    this._name = name;
  }
}
2.3 상속
- extends 키워드 사용
2.4 오버라이드
- @override
- 부모 클래스 또는 인터페이스에 정의된 메서드를 재정의
2.5 인터페이스
- implements
- 여러 개 인터페이스 가능
- 상속과 달리 부모 클래스의 모든 기능을 다시 정의해줘야 함.
2.6 믹스인
- mixin, with 키워드 사용
- 특정 클래스의 원하는 기능만 넣을 수 있는 기능
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

  // 믹스인에 정의된 dance() 함수와 sing() 함수 사용 가능
  bts.sing();
}
2.7 추상
- abstract
- 함수의 반환 타입, 이름, 매개변수만 정의하고, 자식 클래스에서 필수로 정의
2.8 제네릭
- 클래스나 함수의 정의를 선언이 아닌 실행할 때로 미룸
// 인스턴스화할 때 입력받을 타입을 T로 지정합니다.
class Cache<T> {
  // data의 타입을 추후 입력될 T 타입으로 지정합니다.
  final T data;

  Cache({
    required this.data,
  });
}

void main() {
  // T의 타입을 List<int>로 입력합니다.
  final cache = Cache<List<int>>(
    data: [1,2,3],
  );

  // 제네릭에 입력된 값을통해 data 변수의 타입이 자동으로 유추됩니다.
  // reduce() 함수가 기억나지 않는다면 1.3.1절 List타입의 reduce() 함수를 복습해보세요.
  print(cache.data.reduce((value, element) => value + element));
}
2.9 스태틱
- 정적 변수
2.10 캐스케이드 연산자
- .. 기호 사용
- 인스턴스의 속성이나 멤버 함수를 연속해서 사용하는 기능
void main() {
  Idol blackpink = Idol('블랙핑크', 4);
    ..sayName()
    ..sayMembersCount();    
}

03. 다트 비동기 프로그래밍
3.2 Future
- 미래에 받을 값을 정함.
Future<String> name;    // 미래에 받을 String값
Future<int> number;     // 미래에 받을 int값
Future<bool> isOpened;  // 미래에 받을 boolean값
3.3 async와 await
- 코딩한 순서대로 실행되게 함
// async 키워드는 함수 매개변수 정의와 바디 사이에 입력합니다.
void addNumbers(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');

  // await는 대기하고 싶은 비동기 함수 앞에 입력합니다.
  await Future.delayed(Duration(seconds: 3), (){
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 코드 실행 끝');
}
3.3.1 결과값 반환받기
- Future 클래스를 사용하여 async, await 에서 결과 값을 받을 수 있다.
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
3.4 Stream
- Future는 반환값을 한번 받아내는 비동기 프로그램
- Stream은 지속적으로 값을 반환
3.4.1 스트림 기본 사용버
- StreamController 를 listen()
import 'dart:async';

void main() {
  final controller = StreamController();  // StreamController 선언
  final stream = controller.stream;  // Stream 가져오기

  // Stream에 listen() 함수를 실행하면 값이 주입될 때마다 콜백 함수를 실행할 수 있습니다.
  final streamListener1 = stream.listen((val) {
    print(val);
  });

  // Stream에 값을 주입할 때는 sink.add() 함수를 실행하면 됩니다.
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
}
3.4.2 브로드캐스트 스트림
- asBroadcastStream();
- listen() 을 여러 번 실행
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

  // add()를 실행할 때마다 listen()하는 모든 콜백 함수에 값이 주입됩니다.
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);

}
3.4.3 함수로 스트림 반환하기
- 스트림을 반환하는 함수는 async*로 선언하고 yield 키워드로 값을 반환
// Stream을 반환하는 함수는 async*로 선언합니다.
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

