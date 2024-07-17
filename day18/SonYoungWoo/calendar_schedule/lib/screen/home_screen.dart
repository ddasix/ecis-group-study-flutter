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