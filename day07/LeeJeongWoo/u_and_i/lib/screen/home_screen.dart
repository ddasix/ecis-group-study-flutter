import 'package:flutter/material.dart';

// 쿠퍼티노 (iOS) 위젯 사용하기 위해 필요
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],  // 핑크 배경색 적용
      body: SafeArea(   // 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(

              // 하트 눌렀을 때 실행할 함수 전달하기
              onHeartPressed: onHeartPressed,
              firstDay: firstDay, //
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  
  void onHeartPressed() { // 하트 눌렀을 때 실행할 함수
    showCupertinoDialog(  // 쿠퍼티노 다이얼로그 실행
      context: context,   // 보여줄 다이얼로그 빌드
      builder: (BuildContext context) {
        // 날짜 선택하는 다이얼로그
        return Align( // 정렬을 지정하는 위젯
          alignment: Alignment.bottomCenter,  // 아래 중간으로 정렬
          child: Container(
            color: Colors.white,  // 배경색 흰색 지정
            height: 300,  // 높이 300 지정
            child: CupertinoDatePicker(
              // 시간 제외하고 날짜만 선택하기
              mode: CupertinoDatePickerMode.date,
              // 날짜가 변경되면 실행되는 함수
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true, // 외부 탭할 경우 다이얼로그 닫기
    );
  }
}

class _DDay extends StatelessWidget {
  // 하트 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;  // 사귀기 시작한 날
  
  _DDay({
   required this.onHeartPressed,  // 상위에서 함수 입력받기
   required this.firstDay,  // 날짜 변수로 입력받기
});
  
  @override
  Widget build(BuildContext context) {
    // 테마 불러오기
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now(); // 현재 날짜시간

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text( // 최상단 U&I 글자
          'U&I',
          style: textTheme.headlineLarge, // headline1 스타일 적용
        ),
        const SizedBox(height: 16.0),
        Text( // 두 번째 글자
          '우리 처음 만난 날',
          style: textTheme.bodyLarge, // bodyText1 스타일 적용
        ),
        Text( // 임시로 지정한 만난 날짜
          // '2021.11.23',
          // DateTime을 년, 월, 일 형태로 변경
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium, // bodyText2 스타일 적용
        ),
        const SizedBox(height: 16.0),
        IconButton( // 하트 아이콘 버튼
          iconSize: 60.0,
          onPressed: onHeartPressed,  // 아이콘 눌렀을 때 실행할 함수
          icon: Icon(
            Icons.favorite,
            color: Colors.red,  // 색상 빨강으로 변경
          ),
        ),
        const SizedBox(height: 16.0),
        Text( // 만난 후 DDay
          // 'D+365',
          // headline2 스타일 적용
          // DDay 계산하기
          'D+${DateTime(now.year, now.month,
                  now.day).difference(firstDay).inDays + 1}',
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}

// _CoupleImage 위젯 생성
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(  // Expanded 추가
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',

          // Expanded가 우선순위를 갖게 되어 무시됨
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}