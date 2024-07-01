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