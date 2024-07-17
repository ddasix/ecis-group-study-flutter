import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await repository.getSchedules(date: date);  // GET 메서드 보내기

    cache.update(date, (value) => resp, ifAbsent: () => resp);

    notifyListeners();
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    const uuid = Uuid();

    final tempId = uuid.v4();  // 유일무이한 ID값을 생성합니다.
    final newSchedule = schedule.copyWith(
      id: tempId,  // 임시 ID를 지정합니다.
    );

    cache.update(  // 긍정적 응답 구간입니다. 서버에서 응답을 받기전에 캐시를 먼저 업데이트합니다.
      targetDate,
          (value) => [
        ...value,
        newSchedule,
      ]..sort(
            (a, b) => a.startTime.compareTo(
          b.startTime,
        ),
      ),
      ifAbsent: () => [newSchedule],
    );

    notifyListeners();  // 캐시업데이트 반영하기

    try {
      final savedSchedule = await repository.createSchedule(schedule: schedule);  // API 요청을 합니다.

      cache.update(
        targetDate,
            (value) => value
            .map((e) => e.id == tempId
            ? e.copyWith(
          id: savedSchedule,
        )
            : e)
            .toList(),
      );
    } catch (e) {
      cache.update(
        targetDate,
            (value) => value.where((e) => e.id != tempId).toList(),
      );
    }
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
          (e) => e.id == id,
    );  // 삭제할 일정 기억

    cache.update(
      date,
          (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    ); // 긍정적 응답 (응답 전에 캐시 먼저 업데이트)

    notifyListeners();  // 캐시업데이트 반영하기

    try {
      await repository.deleteSchedule(id: id);
    } catch (e) {
      cache.update(
        date,
            (value) => [...value, targetSchedule]..sort(
              (a, b) => a.startTime.compareTo(
            b.startTime,
          ),
        ),
      );
    }

    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;  // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }
}
