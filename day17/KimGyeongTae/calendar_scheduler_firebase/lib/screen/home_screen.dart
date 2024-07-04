import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    // 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isDismissible: true, // 배경 탭 했을때 화면닫기
              isScrollControlled: true,
              builder: (_) => ScheduleBottomSheet(
                selectedDate: selectedDate,
              ),
              // BottomSheet의 높이를 화면의 최대 높이로 정의하고 스크롤 가능하게 변경
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Column(
            children: [
              MainCalendar(
                selectedDate: selectedDate,
                onDaySelected: (selectedDate, focusedDate) =>
                    onDaySelected(selectedDate, focusedDate, context),
              ),
              const SizedBox(
                height: 8.0,
              ),
              StreamBuilder<QuerySnapshot>(
                // ListView에 적용했던 같은 쿼리
                stream: FirebaseFirestore.instance
                    .collection(
                      'schedule',
                    )
                    .where(
                      "date",
                      isEqualTo:
                    "${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}")
                    .snapshots(),
                builder: (context, snapshot) {
                  return TodayBanner(
                    selectedDate: selectedDate,

                    // 개수 가져오기
                    count: snapshot.data?.docs.length ?? 0,
                  );
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  // 파이어스토어로부터 일정 정보 받아오기
                  stream: FirebaseFirestore.instance
                      .collection(
                        'schedule',
                      )
                      .where(
                        "date",
                        isEqualTo:
                      "${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}")
                      .snapshots(),
                  builder: (context, snapshot) {
                    // Stream을 가져오는 동안 에러가 났을 때 보여줄 화면
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('일정 정보를 가져오지 못했습니다.'),
                      );
                    }

                    // 로딩 중일 때 보여줄 화면
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    final schedules = snapshot.data!.docs
                        .map((e) => ScheduleModel.fromJson(
                        json: (e.data() as Map<String, dynamic>)))
                        .toList();

                    return ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];

                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (DismissDirection direction) {
                            FirebaseFirestore.instance
                                .collection('schedule')
                                .doc(schedule.id)
                                .delete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0),
                            child: ScheduleCard(
                              startTime: schedule.startTime,
                              endTime: schedule.endTime,
                              content: schedule.content,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate, BuildContext context) {
    setState(() => this.selectedDate = selectedDate);
  }
}