# Chapter 10. 만난지 며칠 U&I

## 사전지식
### SetState() 함수
- StatefulWidget의 속성값을 변경하여 리빌드.
- 값이 변경되면 dirty 상태로 바뀜.
### ShowCupertinoDialog() 함수
- iOS 스타일의 다이얼로그가 실행. cupertino 패키지 참조.
- 모든 다이얼로그 형태의 함수는 buildContext 함수 입력.
- 위젯이외의 부분을 배리어라고 하며 배리어부분을 클릭하여 다이얼로그를 닫을 수 있음.

### pubspec.yaml 설정
- asset에 이미지와 폰트 설정
```dart
assets:
- asset/img/

fonts:
  - family: parisienne   
    fonts:
    - asset: asset/font/Parisienne-Regular.ttf  

    - family: sunflower
      fonts:
        - asset: asset/font/Sunflower-Light.ttf
        - asset: asset/font/Sunflower-Medium.ttf
          weight: 500  
        - asset: asset/font/Sunflower-Bold.ttf
          weight: 700

```

### main.dart 구현
```dart
import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    ///테마 클래스
    ///선언해 놓으면 자식 위젯에 적용할 수 있음.
    theme: ThemeData(
        fontFamily: "sunflower",  // pubspec에 지정한 폰트 이름
        textTheme: const TextTheme(     // 폰트 테마
            ///스타일 이름 교재 p.252 에는 headline1으로 되어있는데 바뀐듯
            headlineLarge : TextStyle(
            color: Colors.white,  //  글 색상
            fontSize: 80.0,       //  글 크기
            fontWeight: FontWeight.w700, //  글 두께
            fontFamily: 'parisienne',    //  pubspec에 지정한 폰트 이름
          ),
           headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        )
    ),
    home:HomeScreen(),
  ));
}
```
### home_screen.dart 구현
```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  ///statefluwidget은 createState 메서드를 구현해야함.
  ///클래스에 _바를 붙이면 외부파일에서 접근이 안됨.
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

///클래스 이름에 시작이 _이면 다른파일에서 접근금지
///화면을 구현하는 클래스
class _HomeScreenState extends State<HomeScreen>{

  ///첫날은 오늘 일자로 세팅
  DateTime firstday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///전체화면 배경색을 지정함.
      backgroundColor: Colors.amber,
      body: SafeArea( //시스템 ui를 가리지 않은 영역지정
        child: Column( //위아래에 화면을 나누기 위해
          mainAxisAlignment: MainAxisAlignment.spaceBetween,       //위아래 끝에 위젯을 붙임.
          children: [
            ///정보를 나타내는 위쪽화면
            _DDay(
              onHeartPressed: onHeartPressed, //하트 눌렀을때 실행할 함수
              firstDay : firstday,            //오늘일자
            ),
            _CupleImage()],
        ),
      ),
    );
  }

  ///버튼을 눌렀을때 실행되는 콜백함수
  void onHeartPressed()
  {
    ///쿠파치노 다이얼로그를 사용.
    showCupertinoDialog(context: context,
        builder:(BuildContext context){
        ///정렬 위젯(자식위젯 정렬)
        return Align(
          alignment: Alignment.bottomCenter, //중앙아래에 설정하겠다.
          child:Container(
            color: Colors.white, //컨테이너 색은 흰색
            height: 300,         //높이 300
            ///컨테이너에는 쿠퍼티노 날짜선택 위젯 선언
            child: CupertinoDatePicker(
              ///날짜 선택시 시간은 빼고 날짜만 선택 모드
                mode: CupertinoDatePickerMode.date,
            ///날짜 선택갑이 바뀔때 동작하는 이벤트
            onDateTimeChanged: (DateTime date) {
                  ///setState 함수를 쓰면 상태가 변경되었다는 것을 알려주고 build() 메소드가 실행됨.
              setState(() {
                firstday = date;
              });
            }
            ),
          )
        );
        }, barrierDismissible: true);  //다이얼로그 영역 바깥을 선택하면 다이얼로그를 닫음.
  }
}


///위쪽 텍스트 정보를 나타내는 화면
class _DDay extends StatelessWidget {

  ///버튼의 press나 tab 동작 콜백 함수가 타입(typedef p.66)으로 지정되어 있음
  final GestureTapCallback onHeartPressed;
  ///지정한 날짜
  final DateTime firstDay;

  ///네임드 매개변수를 받는 생성자 선언.
  _DDay({
    required this.onHeartPressed,
    required this.firstDay,
});

  @override
  Widget build(BuildContext context) {

    ///main에 지정해놓은 테마중 textTheme
    final textTheme = Theme.of(context).textTheme;
    ///D-DAY를 계산하기 위한 오늘 날짜
    final now = DateTime.now();
     ///세로로 텍스트를
     return Column(
      children: [
        const SizedBox(height: 16,),
        Text("U&I", style: textTheme.headlineLarge,), //Text 스타일에 테마로 지정해놓은 headlineLarge 적용
        const SizedBox(height: 16,),
        Text("우리 처음 만난 날"),
        Text("${firstDay.year}.${firstDay.month}.${firstDay.day}"), //지정한 날짜
        const SizedBox(height: 16,),
        IconButton(
            iconSize: 60,
            onPressed: onHeartPressed,
            icon: Icon(Icons.favorite,color: Colors.red,)),
        const SizedBox(height: 16,),
        Text(
          ///현재일자에서 지정한 일자를 뺀 일수를 D day로 표시
          "D+${DateTime(now.year,now.month,now.day).difference(firstDay).inDays + 1}",
          style: textTheme.headlineMedium,
        )
      ],
     );
  }
}

//아래쪽 커플 그림 화면
class _CupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ///Expanded 위젯으로 남은 공간을 꽉채움 p.166
    return Expanded(
    child: Center(
      ///MediaQuery는 현재 비율,밝기 등 현재 화면 정보를 가져옴
      ///MaterialApp이 실행될때 MediaQuery가 생성되며 가장 가까운 MediaQuery정보를 가져옴.
      ///깊은 위젯 트리에서 과도하게 사용하면 성능저하가 발생할 수 있음.
      child: Image.asset("asset/img/middleimage.png",height: MediaQuery.of(context).size.height /2,),
    )
    );
  }
}

```
