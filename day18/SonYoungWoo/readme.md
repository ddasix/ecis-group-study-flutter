# Chapter 21. JWT를 이용한 인증하기
## 사전지식
### 인증
- 서버와 통신하는 사용자와의 정보와 유효성을 검증하는 작업.
### JWT
- 헤더(토큰의 정보),페이로드(사용자 정보),시그니처(토큰의 유효성) 세가지 요소로 구성.
- URL base64로 인코딩되어 URL에 String 값으로 전송.
- 엑세스 토큰(접근 권한)과 리프레시 토큰(접근 후 엑세스토큰 폐기 후 발금)
 
## 사전준비
### 서버프로젝트 설정
- ch21/calendar_scheduler_server 실행
- 터미널에서 npm install, npm run start:dev 실행
### 플러터 템플릿 설치
- ch21/calendar_scheduler_template 실행 및 진행

## main 구현
```dart
import 'package:calendar_schedule/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schedule/database/drift_database.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';
import 'package:calendar_schedule/repository/schedule_repository.dart';
import 'package:calendar_schedule/provider/schedule_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:calendar_schedule/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting();

  //db 선언
  //final database = LocalDatabase();

  //database를 전역 선언
  //GetIt.I.registerSingleton<LocalDatabase>(database);

  //final repository = ScheduleRepository();
  //final schduleProvider = ScheduleProvider(repository: repository);

  runApp(
    /*
    ChangeNotifierProvider(create: (_) => schduleProvider,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ) ,
    ),
    */
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}
```
##

## schedule_bottom_sheet 구현
```dart
import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/custom_text_field.dart';
import 'package:calendar_schedule/const/colors.dart';
//material.dart 의 Colum과 중복되어서 숨김
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:calendar_schedule/database/drift_database.dart';
import 'package:path/path.dart';

//import 'package:provider/provider.dart';
import 'package:calendar_schedule/model/schedule_model.dart';
//import 'package:calendar_schedule/provider/schedule_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const ScheduleBottomSheet({super.key, required this.selectedDate});

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
                        onPressed: ()=> onSavePressed(context), //프로바이더로 변경-context전달
                        child: Text("저장"),
                      ),
                    )
                  ],
                ),
              )
          )),
    );

  }

void onSavePressed(BuildContext context) async {
    //form서브에 있는 모든 TextFormField validate 검증
    if(formKey.currentState!.validate()){
      formKey.currentState!.save(); //모든 TextFormField들의 onSaved 매개 변수에 입력된 함수 실행
/*
      await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
             startTime: Value(startTime!),
             endTime: Value(endTime!),
             content: Value(content!),
             date: Value(widget.selectedDate),
          ),
      );

      context.read<ScheduleProvider>().createSchduels(
          schedule: ScheduleModel(
            id: "tmp_id",//서버에서 자동 생성된 값으로 대체
            content: content!,
            date: widget.selectedDate,
            startTime: startTime!,
            endTime: endTime!,
          ),);
*/

      final schedule = ScheduleModel(
          id: Uuid().v4(),
          content: content!,
          date: widget.selectedDate,
          startTime: startTime!,
          endTime: endTime!);

      //스케줄 모델 파이어 스토어에 삽입
      await FirebaseFirestore.instance.collection("schedule",).doc(schedule.id).set(schedule.toJson());

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
import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:calendar_schedule/provider/schedule_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendar_schedule/model/schedule_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

//class HomeScreen extends StatelessWidget{
  //선택된 날짜를 관리
  DateTime selectedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {

    //프로바이더 변경이 있으면 다시 build 함수 실행
    //provider 패키지를 불러와야함.
    //final provier = context.watch<ScheduleProvider>();
    //final selectDate = provier.selectedDate;
    //final schedules = provier.cache[selectedDate] ?? [];

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
                  onDaySelected: (selectDate, focusedDate) => onDaySelected(selectDate,focusedDate,context),
                ),
                SizedBox(height: 8,),
                /*
                StreamBuilder<List<Schedule>>(
                    stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                    builder: (context, snapshot){
                      return TodayBanner(
                          selectedDate: selectedDate,
                          count: snapshot.data?.length ?? 0);
                    }),*/
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.
                  instance.
                  collection("schedule",).
                  where("date",isEqualTo: "${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day}",).
                  snapshots(),
                  builder: (context, snapshot){
                    return TodayBanner(selectedDate: selectedDate,
                        count: snapshot.data?.docs.length ?? 0,);
                  },
                ),
                SizedBox(height: 8,),
                /*
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
                    ),
                ),*/
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.
                      instance.
                      collection("schedule",).
                      where("date",isEqualTo: "${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day}",).
                      snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){ //데이터가 없을때 빈 컨테이너
                          return Center(
                            child: Text("일정 정보를 가져오지 못했습니다."),
                          );
                        }
                        //로딩중일때 보여줌
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Container();
                        }
                        //데이터 매핑
                        final schedules = snapshot.data!.docs.map(
                            (QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                              json: (e.data() as Map<String,dynamic>)),
                            ).toList();

                        return  ListView.builder(
                            itemCount: schedules.length,
                            itemBuilder:(context, index){
                              final schedule = schedules[index];

                              return Dismissible( //옆으로 밀어서 삭제
                                  key: ObjectKey(schedule.id), //유니크한 키값
                                  direction: DismissDirection.startToEnd, //왼쪽에서 오른쪽 밀기
                                  onDismissed: (DismissDirection direction) { //밀었을때 삭제 쿼리실행
                                    //provier.deleteSchedule(date: selectDate, id: schedule.id);
                                    FirebaseFirestore.instance.collection("schedule").doc(schedule.id).delete();
                                  },
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
                                    child: ScheduleCard( //ScheduleCard 위젯에 화면에 나타낼 데이터 전달
                                        startTime: schedule.startTime,
                                        endTime: schedule.endTime,
                                        content: schedule.content
                                    ),
                                  )
                              );
                            },
                        );
                      }
                    )

                ),
              ],
            )
        )
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate, BuildContext context)
  {

    setState(() {
      this.selectedDate = selectedDate;
    });


    //final provier = context.read<ScheduleProvider>();
    //provier.changeSelectedDate(date: selectedDate,);
    //provier.getSchdules(date: selectedDate);
  }

}
```
##
