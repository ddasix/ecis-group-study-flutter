import 'package:calendar_scheduler/components/main_calendar.dart';
import 'package:calendar_scheduler/components/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/components/today_banner.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:calendar_scheduler/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    final selectedDay = provider.selectedDate;
    final schedules = provider.cache[selectedDay] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              onDaySelected: (selectedDay, focusedDay) => onDaySelected(
                context: context,
                focusedDay: focusedDay,
                selectedDay: selectedDay,
              ),
              selectedDay: selectedDay,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              count: schedules.length,
            ),
            const SizedBox(
              height: 8.0,
            ),
            ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];

                return Dismissible(
                  key: ObjectKey(schedule.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    provider.deleteSchedule(date: selectedDay, id: schedule.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: ScheduleCard(
                      startTime: schedule.startTime,
                      endTime: schedule.endTime,
                      contents: schedule.content,
                    ),
                  ),
                );
              },
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
            builder: (context) => ScheduleBottomSheet(
              selectedDate: selectedDay,
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void onDaySelected({
    required DateTime selectedDay,
    required DateTime focusedDay,
    required BuildContext context,
  }) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSelectedDate(
      date: selectedDay,
    );
    provider.getSchedules(
      date: selectedDay,
    );
  }
}
