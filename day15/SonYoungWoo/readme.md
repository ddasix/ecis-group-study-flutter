# Chapter 18. 데이터베이스 적용하기
## 사전지식
### sqlLite
- 프론트앤드에서 사용하는 가벼운 데이터베이스
 
### 드리프트 플러그인
- sql를 작성하지 않고 데이터베이스를 제어할 수 있게하는 orm 기능

### Dismissible 위젯
- 위젯을 밀어서 삭제하는 기능을 제공.
 vertical - 세로로의 움직임을 모두 허가. 위-아래, 아래-위
 horizontal - 가로로의 움직임을 모두 허가. 좌-우, 우-좌
 endToStart - 글을 읽는 반대 방향으로만 움직임 허가. 우-좌
 startToEnd - 글을 읽는 방향으로만 움직임 허가. 좌-우
 up - 아래-위
 down - 위-아래
 none - 어떠한 제스쳐도 허가 x
 
### 테이블 생성
- 테이블 클래스 생성

- 테이블 관련 코드 생성
- flutter pub run build_runner build

 
## drift_database 구현
```dart
import 'package:drift/drift.dart';
import 'package:calendar_schedule/model/schedule.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part "drift_database.g.dart";  // part 파일 지정

@DriftDatabase(  // 사용할 테이블 등록
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {

  LocalDatabase() : super(_openConnection());

  //조회
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  //추가
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  //삭제
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  //테이블 버전
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();  //db 저정 폴더
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

```
## main 구현
```dart
import 'package:calendar_schedule/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schedule/database/drift_database.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  //db 선언
  final database = LocalDatabase();

  //database를 전역 선언
  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
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

  final FormFieldSetter<String> onSaved; //폼필드 저장 
  final FormFieldValidator<String> validator; //폼필드 검증 

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
               onSaved: onSaved, //저장했을때 함수
               validator: validator, //검증 할때 함수
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

## schedule_bottom_sheet 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/custom_text_field.dart';
import 'package:calendar_schedule/const/colors.dart';
//material.dart 의 Colum과 중복되어서 숨김
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:calendar_schedule/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const ScheduleBottomSheet({super.key, required this.selectedDate});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();

}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet>{

   final GlobalKey<FormState> formKey = GlobalKey(); //폼키
   int? startTime; //시작일시 저장변수
   int? endTime;   //종료일시 저장변수
   String? content; //내용 저장변수

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
                          onSaved: (String? val){ //저장
                            startTime = int.parse(val!);
                          },
                          validator: timeValidator, //검증
                        )),
                        const SizedBox(width: 16,),
                        Expanded(child: CustomTextField(
                          label: "종료 시간",
                          isTime: true,
                          onSaved: (String? val){ //저장
                            endTime = int.parse(val!);
                          },
                          validator: timeValidator, //검증
                        ))
                      ],
                    ),
                    SizedBox(height: 8,),
                    Expanded(child: CustomTextField(
                      label: "내용",
                      isTime: false,
                      onSaved: (String? val){ //저장
                        content = val;
                      },
                      validator: contentValidator, //검증
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

void onSavePressed() async {
    //form서브에 있는 모든 TextFormField validate 검증
    if(formKey.currentState!.validate()){
      formKey.currentState!.save(); //모든 TextFormField들의 onSaved 매개 변수에 입력된 함수 실행

      await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
             startTime: Value(startTime!),
             endTime: Value(endTime!),
             content: Value(content!),
             date: Value(widget.selectedDate),
          ),
      );

      Navigator.of(context).pop(); //일정생성 후 뒤로 가기
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

## home_screen 구현
```dart
import 'package:calendar_schedule/component/today_banner.dart';
import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/main_calendar.dart';
import 'package:calendar_schedule/const/colors.dart';
import 'package:calendar_schedule/component/schedule_card.dart';
import 'package:calendar_schedule/component/schedule_bottom_sheet.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_schedule/database/drift_database.dart';


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
              builder: (_)=>ScheduleBottomSheet(
                selectedDate: selectedDate,
              ),//bottomsheet
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
                StreamBuilder<List<Schedule>>(
                    stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                    builder: (context, snapshot){
                      return TodayBanner(
                          selectedDate: selectedDate,
                          count: snapshot.data?.length ?? 0);
                    }),
                SizedBox(height: 8,),
                Expanded(
                    child: StreamBuilder<List<Schedule>>(
                      //데이터 조회
                      stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                      builder: (context, snapshot){
                        if(!snapshot.hasData){ //데이터가 없을때 빈 컨테이너
                          return Container();
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length, //리스트에 보여질 갯수
                            itemBuilder:(context, index){
                              final schedule = snapshot.data![index]; //현재 인덱스에 해당되는..
                              return Dismissible( //옆으로 밀어서 삭제
                                  key: ObjectKey(schedule.id), //유니크한 키값
                                  direction: DismissDirection.startToEnd, //왼쪽에서 오른쪽 밀기
                                  onDismissed: (DismissDirection direction) { //밀었을때 삭제 쿼리실행
                                    GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                                  },
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
                                    child: ScheduleCard( //ScheduleCard 위젯에 화면에 나타낼 데이터 전달
                                        startTime: schedule.startTime,
                                        endTime: schedule.endTime,
                                        content: schedule.content),
                                  )
                                  );
                            });
                      },
                    ) ),
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
