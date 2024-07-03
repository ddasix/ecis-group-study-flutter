import 'dart:io';

import 'package:calendar_scheduler/models/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  final _dio = Dio();
  final _tartgetUrl =
      "http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule";

  Future<List<ScheduleModel>> getSchedules({
    required DateTime date,
  }) async {
    final response = await _dio.get(
      _tartgetUrl,
      queryParameters: {
        'date':
            '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}'
      },
    );

    return response.data
        .map<ScheduleModel>((schedule) => ScheduleModel.fromJson(schedule))
        .toList();
  }

  Future<String> createSchedule({
    required ScheduleModel schedule
  }) async {
    final data = schedule.toJson();
    final response = await _dio.post(_tartgetUrl, data: data);

    return response.data?['id'];
  }

  Future<String> deleteSchedule({
    required String id,
  }) async {
    final response = await _dio.delete(_tartgetUrl, data: {
      'id': id,
    });

    return response.data?['id'];
  }
}
