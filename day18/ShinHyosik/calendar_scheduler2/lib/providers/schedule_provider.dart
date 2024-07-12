import 'package:calendar_scheduler/models/schedule_model.dart';
import 'package:calendar_scheduler/repositories/auth_repository.dart';
import 'package:calendar_scheduler/repositories/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository;
  final AuthRepository authRepository;
  final uuid = Uuid();
  
  String? accessToken;
  String? refreshToken;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository,
    required this.authRepository,
  }) {
    // getSchedules(date: selectedDate);
  }

  changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = date;

    notifyListeners();
  }

  void getSchedules({required DateTime date}) async {
    final response = await repository.getSchedules(date: date, accessToken: accessToken!,);

    cache.update(
      date,
      (value) => response,
      ifAbsent: () => response,
    );

    notifyListeners();
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    final newId = uuid.v4();
    final newSchedule = schedule.copyWith(
      id: newId,
    );

    cache.update(
      targetDate,
      (value) {
        return [...value, newSchedule]..sort(
            (a, b) => a.startTime.compareTo(b.startTime),
          );
      },
      ifAbsent: () => [newSchedule],
    );

    notifyListeners();

    try {
      final savedSchedule = await repository.createSchedule(schedule: schedule, accessToken: accessToken!);

      cache.update(
        targetDate,
        (value) => value
            .map(
              (el) => el.id == newId ? el.copyWith(id: savedSchedule) : el,
            )
            .toList(),
        ifAbsent: () => [schedule],
      );
    } catch (e) {
      cache.update(
        targetDate,
        (value) => value
            .where(
              (el) => el.id != newId,
            )
            .toList(),
      );
    }

    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
      (el) => el.id == id,
    );

    cache.update(
      date,
      (value) => value.where((el) => el.id != id).toList(),
      ifAbsent: () => [],
    );

    notifyListeners();

    try {
      await repository.deleteSchedule(id: id, accessToken: accessToken!);
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
  
  updateToken({
    String? refreshToken,
    String? accessToken,
  }) {
    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }

    if (accessToken != null) {
      this.accessToken = accessToken;
    }

    notifyListeners();
  }

  register({
    required String email,
    required String password,
  }) async {
    final response = await authRepository.register(
      email: email,
      password: password,
    );

    updateToken(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response =
        await authRepository.login(email: email, password: password);

    updateToken(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }

  logout() {
    this.refreshToken = null;
    this.accessToken = null;

    cache = {};

    notifyListeners();
  }

  rotateToken({
    required String refreshToken,
    required bool isRefreshToken,
  }) async {
    if (isRefreshToken) {
      final token = await authRepository.rotateRefreshToken(refreshToken: refreshToken);
      this.refreshToken = token;
    } else {
      final token = await authRepository.rotateAccessToken(refreshToken: refreshToken);
      this.accessToken = token;
    }

    notifyListeners();
  }
}
