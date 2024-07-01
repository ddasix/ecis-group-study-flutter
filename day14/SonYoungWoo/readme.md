# Chapter 17. 일정 관리 앱 만들기
## 사전지식
### table_caledar 플러그인
- 특정날짜 선택, 기간 선택,날짜지정하기 등 기능
 
### 사전준비
- 구글 클라우드 콘솔에서 Youtube data api v3 활성화.
 
### pubspec.yaml 설정
table_calendar: 3.0.9
intl: 0.18.1
drift: 2.13.0
sqlite3_flutter_libs: 0.5.17
path_provider: 2.1.1
path: ^1.9.0
get_it: 7.6.4
dio: 5.3.3
provider: 6.0.5
uuid: 4.1.0

## main 구현
```dart
import 'package:calendar_schedule/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schedule/database/drift_database.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
 
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}
```
## home_screen 구현
```dart
import 'package:calendar_schedule/component/today_banner.dart';
import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/main_calendar.dart';
import 'package:calendar_schedule/const/colors.dart';
import 'package:calendar_schedule/component/schedule_card.dart';
import 'package:calendar_schedule/component/schedule_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //선택된 날짜를 관리
  DateTime selectedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton( //플로팅 액션버튼 생성
        backgroundColor: PRIMARY_COLOR,
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_)=>ScheduleBottomSheet(),//bottomsheet
             isDismissible: true //배경선택시 닫기
          );
        },
        child: Icon(Icons.add),
      ),

        body: SafeArea(
            child: Column(
              children: [
                MainCalendar(
                  selectedDate: selectedDate,
                  onDaySelected: onDaySelected,
                ),
                SizedBox(height: 8,),
                TodayBanner(selectedDate: selectedDate, count: 0),
                SizedBox(height: 8,),
                ScheduleCard(startTime: 12, endTime: 14, content: "프로그래밍 공부")
              ],
            )
        )
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate)
  {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

}
```

## custom_text_field 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/const/colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomTextField({super.key, required this.label, required this.isTime, required this.onSaved, required this.validator});

  @override
  Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           label,
           style: TextStyle(
             color: PRIMARY_COLOR,
             fontWeight: FontWeight.w600,
           ),
         ),
         Expanded(
             flex: isTime? 0:1,
             child: TextFormField(
               onSaved: onSaved,
               validator: validator,
               cursorColor: Colors.grey,
               maxLines: isTime ? 1:null,
               expands: !isTime,
               keyboardType: isTime? TextInputType.number:TextInputType.multiline,
               inputFormatters: isTime?
               [FilteringTextInputFormatter.digitsOnly,]:[],
               decoration: InputDecoration(
                 border: InputBorder.none,
                 filled: true,
                 fillColor: Colors.grey[300],
                 suffixText: isTime ? "시":null,
               ),
             ))
         ,
       ],
     );
  }

}
```

## main_calendar 구현
```dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_schedule/const/colors.dart';


class MainCalendar extends StatelessWidget{
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    required this.onDaySelected,
    required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: "ko_kr",
        onDaySelected: onDaySelected,
        selectedDayPredicate: (date)=> //날짜 선택시 실행함수
        date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day,
        focusedDay: DateTime.now(), //현재날짜 -포커스
        firstDay: DateTime(1800,1,1), //첫째날
        lastDay: DateTime(3000,1,1), //마지막날

      headerStyle: const HeaderStyle(
         titleCentered: true, //제목 중앙에
         formatButtonVisible: false, //달력 크기 선택 옵션 비활성
         titleTextStyle: TextStyle( //제목 글꼴
           fontWeight: FontWeight.w700,
           fontSize: 16.0,
         )
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false, //오늘 날짜 강조 비활성
        defaultDecoration: BoxDecoration(  //기본 날짜 박스 스타일
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
        ),
         weekendDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
         ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          ),
        ),
        defaultTextStyle: TextStyle( //기본 날짜폰트 스타일
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: PRIMARY_COLOR,
        )
      ),
    );
  }
}
```

## schedule_bottom_sheet 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/custom_text_field.dart';
import 'package:calendar_schedule/const/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});
  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();

}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet>{

   final GlobalKey<FormState> formKey = GlobalKey();
   int? startTime;
   int? endTime;
   String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height /2 + bottomInset,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8,bottom: bottomInset),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          label: "시작 시간",
                          isTime: true,
                          onSaved: (String? val){
                            startTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        )),
                        const SizedBox(width: 16,),
                        Expanded(child: CustomTextField(
                          label: "종료 시간",
                          isTime: true,
                          onSaved: (String? val){
                            endTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        ))
                      ],
                    ),
                    SizedBox(height: 8,),
                    Expanded(child: CustomTextField(
                      label: "내용",
                      isTime: false,
                      onSaved: (String? val){
                        content = val;
                      },
                      validator: contentValidator,
                    )),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onSavePressed,
                        child: Text("저장"),
                      ),
                    )
                  ],
                ),
              )
          )),
    );

  }

void onSavePressed(){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      print(startTime);
      print(endTime);
      print(content);
    }

}

String? timeValidator(String? val) {

  if (val == null) {
    return '값을 입력해주세요';
  }

  int? number;

  try {
    number = int.parse(val);
  } catch (e) {
    return '숫자를 입력해주세요';
  }

  if (number < 0 || number > 24) {
    return '0시부터 24시 사이를 입력해주세요';
  }

}

String? contentValidator(String? val) {

  if (val == null || val.length == 0) {
    return '값을 입력해주세요';
  }
  return null;
}
}
```

## schedule_card 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleCard({
    super.key
, required this.startTime, required this.endTime, required this.content});

  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         border: Border.all(
           width: 1.0,
           color: PRIMARY_COLOR,
         ),
         borderRadius: BorderRadius.circular(8.0),
       ),
       child: Padding(
         padding: const EdgeInsets.all(16),
         child: IntrinsicHeight( //높이를 내부 위젯 최대 높이로
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               _Time(startTime: startTime, endTime: endTime),
               SizedBox(width: 16,),
               _Content(content: content),
               SizedBox(width: 16,)
             ],
           ),
         ),
       ),
     );
  }

}

class _Time extends StatelessWidget {

  final int startTime;
  final int endTime;

  const _Time({super.key,
   required this.startTime,
    required this.endTime});

  @override
  Widget build(BuildContext context) {
   final textStyle = TextStyle(
     fontWeight: FontWeight.w600,
     color: PRIMARY_COLOR,
     fontSize: 16.0
   );

   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text( //숫자가 2자리 안되면 앞에 0
         "${startTime.toString().padLeft(2,"0")}:00",
         style: textStyle,
       ),
       Text( //숫자가 2자리 안되면 앞에 0
         "${endTime.toString().padLeft(2,"0")}:00",
         style: textStyle.copyWith(
           fontSize: 10.0,
         ),
       ),
     ],
   );
  }

}

class _Content extends StatelessWidget {
  final String  content; //내용
  const _Content({super.key,required this.content});

  @override
  Widget build(BuildContext context) {
   return Expanded(
       child: Text(
         content
       ));
  }
}
```
## today_banner 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;  // 선택날짜
  final int count;  // 일정 개수

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(  // 기본으로 사용할 글꼴
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',  // “년 월 일” 형태로 표시
              style: textStyle,
            ),
            Text(
              '$count개',  // 일정 개수 표시
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

```
