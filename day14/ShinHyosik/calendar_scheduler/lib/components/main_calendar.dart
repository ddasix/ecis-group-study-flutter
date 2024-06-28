import 'package:calendar_scheduler/constants/colors.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDay;

  const MainCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_Kr',
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime day) =>
          day.year == selectedDay.year &&
          day.month == selectedDay.month &&
          day.day == selectedDay.day,
      focusedDay: DateTime.now(),
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2050, 12, 31),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY_COLOR,
        ),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          ),
        ),
        defaultTextStyle: TextStyle(
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
        ),
      ),
    );
  }
}
