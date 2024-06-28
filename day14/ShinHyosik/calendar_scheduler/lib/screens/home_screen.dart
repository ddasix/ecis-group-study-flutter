import 'package:calendar_scheduler/components/main_calendar.dart';
import 'package:calendar_scheduler/components/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/components/today_banner.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              onDaySelected: onDaySelected,
              selectedDay: selectedDay,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              count: 0,
            ),
            const SizedBox(
              height: 8.0,
            ),
            ScheduleCard(
              startTime: 12,
              endTime: 14,
              contents: '프로그래밍 공부',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (context) => ScheduleBottomSheet(),
            isScrollControlled: true,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }
}
