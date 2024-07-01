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