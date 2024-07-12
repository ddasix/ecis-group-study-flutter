import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:calendar_scheduler/repository/auth_repository.dart';

class ScheduleProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ScheduleRepository repository;

  String? accessToken;
  String? refreshToken;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider(
    this.authRepository, {
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await repository.getSchedules(
      date: date,
      accessToken: accessToken!,
    );

    cache.update(date, (value) => resp, ifAbsent: () => resp);
    notifyListeners();
  }

  void createSchedules({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    final uuid = Uuid();
    final tempId = uuid.v4();
    final newSchedule = schedule.copyWith(
      id: tempId,
    );

    cache.update(
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
    notifyListeners();

    try {
      final savedSchedule = await repository.createSchedule(
        schedule: schedule,
        accessToken: accessToken!,
      );

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
    notifyListeners();
  }

  void deleteSchedules({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id,
    );
    cache.update(
      date,
      (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    );
    notifyListeners();

    try {
      await repository.deleteSchedule(
        id: id,
        accessToken: accessToken!,
      );
    } catch (e) {
      cache.update(
        date,
        (value) => [
          ...value,
          targetSchedule,
        ]..sort(
            (a, b) => a.startTime.compareTo(
              b.startTime,
            ),
          ),
      );
      notifyListeners();
    }
    notifyListeners();
  }

  void changeSelectedDate({
    required DateTime date,
  }) async {
    selectedDate = date;
    notifyListeners();
  }

  updateTokens({
    String? refreshToken,
    String? accessToken,
  }) {
    // 각 토큰이 입력됐을 경우 업데이트
    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }

    if (accessToken != null) {
      this.accessToken = accessToken;
    }

    notifyListeners();
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final resp = await authRepository.register(
      //AuthRepository 에 구현해둔 register 함수 호출
      email: email,
      password: password,
    );

    updateTokens(
      //반환받은 토큰을 기반으로 토큰 프로퍼티 업데이트
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final resp = await authRepository.login(
      //AuthRepository 에 구현해둔 register 함수 호출
      email: email,
      password: password,
    );

    updateTokens(
      //반환받은 토큰을 기반으로 토큰 프로퍼티 업데이트
      refreshToken: resp.refreshToken,
      accessToken: resp.accessToken,
    );
  }

  logout() {
    // 토큰을 null 로 업데이트 해서 로그아웃
    refreshToken = null;
    accessToken = null;

    // 일정 정보 캐시도 모두 삭제
    cache = {};
    notifyListeners();
  }

  retateToken({
    required String refreshToken,
    required bool isRefreshToken,
  }) async {
    // isRefreshToken이 true 면 refresh 토큰 재발급, false 면 access 토큰 재발급
    if (isRefreshToken) {
      final token =
          await authRepository.rotateRefreshToken(refreshToken: refreshToken);
      this.refreshToken = token;
    } else {
      final token =
          await authRepository.rotateAcessToken(refreshToken: refreshToken);
      accessToken = token;
      notifyListeners();
    }
  }
}
