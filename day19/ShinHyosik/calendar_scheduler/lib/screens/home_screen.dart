import 'package:calendar_scheduler/components/main_calendar.dart';
import 'package:calendar_scheduler/components/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/components/today_banner.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:calendar_scheduler/models/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

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
    // final provider = context.watch<ScheduleProvider>();
    // final selectedDay = provider.selectedDate;
    // final schedules = provider.cache[selectedDay] ?? [];

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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('schedule')
                  .where(
                    'date',
                    isEqualTo:
                        '${selectedDay.year}${selectedDay.month}${selectedDay.day}',
                  )
                  .where('author', isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDay: selectedDay,
                  count: snapshot.data?.docs.length ?? 0,
                );
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('schedule')
                    .where(
                      'date',
                      isEqualTo:
                          '${selectedDay.year}${selectedDay.month}${selectedDay.day}',
                    )
                    .where('author', isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('일정 정보를 가져오지 못했습니다.'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  final schedules = snapshot.data!.docs
                      .map(
                        (e) => ScheduleModel.fromMap(
                            (e.data() as Map<String, dynamic>)),
                      )
                      .toList();

                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('schedule')
                              .doc(schedule.id)
                              .delete();
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
                  );
                },
              ),
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
    setState(() {
      this.selectedDay = selectedDay;
    });
    // final provider = context.read<ScheduleProvider>();
    // provider.changeSelectedDate(
    //   date: selectedDay,
    // );
    // provider.getSchedules(
    //   date: selectedDay,
    // );
  }
}
