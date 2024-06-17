# Chapter 03. 다트 비동기 프로그래밍
- 동기 : 요청 후 결과가 나올때까지 기다렸다가 다음 코드로 진행.
- 비동기 : 요청 후 결과를 기다리지 않고 다음 코드로 진행.
### Future
- 다트에서 비동기 처리를 위한 클래스.
- 지금은 없지만 미래에 요청한 데이터 혹은 에러가 담길 그릇.
```dart
void main() {

 print("첫번째 출력");
 Future.delayed(Duration(seconds: 3),() {
   print("두번째 출력");
 });
 print("세번째 출력");

}
```
### async / await
- Future 를 좀더 유용하게 사용하기 위한 키워드.
- await 키워드를 사용한 함수는 무조건 async 함수.
- 비동기 특성을 유지하면서 작성한 순서대로 실행.
```dart
Future<int> addTwoNumber(int a, int b) async
{
  return a + b;
}

void main() {

 print("첫번째 출력");

 print("두번째 계산 = ${await addTwoNumber(1, 2)}");

 print("세번째 출력");
}
```
### Stream
- 지속적으로 값을 반환 받을 때 사용하는 비동기 연산자
- dart:async 패키지를 참조.
- StreamController의 liten 함수를 이용하여 값을 지속적으로 반환.
```dart
import 'dart:async';

void main() {
 final controller = StreamController();
 final stream = controller.stream;

 final streamlisener = stream.listen((val) {
   print(val);
 });

 controller.sink.add(1);
 controller.sink.add(2);
 controller.sink.add(3);
}
```
### BrodcastStream
- 하나의 스트림을 생성하고 여러번 listen 함수를 실행.
```dart
import 'dart:async';

void main() {
 final controller = StreamController();
 final stream = controller.stream.asBroadcastStream();

 final streamlisener1 = stream.listen((val) {
   print("listening1");
   print(val);
 });
 final streamlisener2 = stream.listen((val) {
   print("listening2");
   print(val);
 });

 controller.sink.add(1);
 controller.sink.add(2);
 controller.sink.add(3);
}
```
# Chapter 04. 다트 3.0 신규문법입문하기

## 레코드
- 다트 3.0부터 추가된 기능.
- 포지셔널 파라미터나 네임드 파라미터를 이용하여 사용.
- 포지셔널 파라미터를 사용할때는 순서대로 기술해야함.
- 각 값을 알고 싶다면 $1...$n 형태로 가져올 수 있음.
- 네임드 파라미터는 순서와 상관없음
```dart
void main()  {
  (String, int) Minji = ("민지",20);
  print(Minji);
  print(Minji.$1);
  
  ({String name, int age}) Youngwoo = (age: 45,name: "영우");
  print(Youngwoo.name);

}
```
## 구조분해
- 반환 타입을 복제하여 타입 내부에서 값을 추출
```dart
void main()  {

  //리스트에서의 구조분해
  final [dog, cat] = ["멍멍","야옹"];
  print(dog);

  //스프레드 연산자를 이용한 구조분해
  final number = [1,3,4,5,6,7];
  final [a,b,c,...,z] = number;
  print(z);

  //맵에서의 구조분해
  final minjiMap = {"name":"민지", "age":19};
  final {"name" : name, "age":age} = minjiMap;
  print(name);
  print(age);
  
  //클래스에서의 구조분해
  final dog = dogs(name:"댕댕이", age: 29);
  final dogs(name:name,age:age) = dog;
  print(name);
  print(age);
 
 }

class dogs {
  final String name;
  final int age;

  dogs({required this.name, required this.age});

}
```
## switch 문
### 표현식 가능
- 3.0에선 switch 문을 함수처럼 사용하여 값을 반환받을 수 있음.
```dart
void main()  {

  String dayKor  = "화요일";

  String dayEnglish = switch(dayKor) {
    "월요일"=> "Monday",
    "화요일"=> "Tuesday",
    "수요일"=> "Wednesday",
    _=> "없음"
  };

  print(dayEnglish);

}

```
### 패턴매칭
```dart
void main()  {

  sw((1,"a"));
}

void sw(dynamic any)
{
   switch(any) {
     case "aaa":
       print(any);
       break;
     case [1,2]:
       print(any);
       break;
     case [_,_,_]:
       print(any);
       break;
     case [int a , String b]:
       print(any);
       break;
     case (int a , String c):
       print(any);
       break;
   }
}
```
### 엄격한검사
- 입력값에 대한 모든 조건 검사
```dart
void main()  {

  bool? val;

  switch(val) {
    case true:
      print("true");
      break;
    case false:
      print("false");
      break;
    default:
      print("null");
      break;
  }

}
```
### 보호구문
- when 키워드로 보호 구문을 추가.
- 반환된 boolean 값을 각 case 문에 추가하여 true 일때만 실행
```dart
void main()  {

  (int a, int b) val = (1,-1);

  switch(val) {
    case (1,_) when val.$2 > 0:
      print("1,_");
      break;
  }

}
```
## 클래스 제한자
- base,final,interface, sealed, mixin 등의 클래스 제한자가 추가.
- class 키워드 앞에 명시.
- 다른 파일에 작성해야 정상적으로 기능이 동작.
### base 제한자
- 해당 클래스는 상속만 가능.
- 자식클래스는 반드시 base,final,sealed 제한자만 허용
```dart
base class Parent{}

import 'dart.dart';

//인스턴스화 가능
Parent parent = Parent();

//base 를 붙였기 때문에 상속가능
base class Child extends Parent{}
//오류남
class Child2 extends Parent{}
//오류남
class Child3 implements Parent{}
```
### final 제한자
- base 제한자의 기능을 모두 포함.
- 같은 파일내에서 상속과 재정의는 가능하지만 외부파일에서는 인스턴스화만 가능.
```dart
final class Parent{}

import 'dart.dart';

//인스턴스화 가능
Parent parent = Parent();

//오류남
base class Child extends Parent{}
//오류남
class Child1 extends Parent{}
//오류남
class Child2 implements Parent{}
```
### interface 제한자
- 외부파일에서 상속받지 못하고 재정의만 가능.
```dart
interface class Parent{}

import 'dart.dart';

//인스턴스화 가능
Parent parent = Parent();

//오류남
base class Child extends Parent{}
//오류남
class Child1 extends Parent{}

class Child2 implements Parent{}
```

### sealed 제한자
- 외부 파일에서 인스턴스화도 불가능.
```dart
sealed class Parent{}

import 'dart.dart';

//오류남
Parent parent = Parent();

//오류남
base class Child extends Parent{}
//오류남
class Child1 extends Parent{}
//오류남
class Child2 implements Parent{}
```
### mixin 제한자
- 클래스에서도 mixin 사용가능.
- 일반 mixin과 같은 역할을 하면서도 상속가능.
```dart
sealed class Parent{}

import 'dart.dart';

//인스턴스화 가능
Parent parent = Parent();

base class Child extends Parent{}
class Child2 extends Parent{}
class Child3 implements Parent{}
class Child4 with Parent{}
```
