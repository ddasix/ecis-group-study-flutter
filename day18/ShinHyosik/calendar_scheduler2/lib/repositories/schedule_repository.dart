import 'dart:io';

import 'package:calendar_scheduler/models/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  final _dio = Dio();
  final _tartgetUrl =
      "http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule";

  Future<List<ScheduleModel>> getSchedules({
    required String accessToken,
    required DateTime date,
  }) async {
    final response = await _dio.get(_tartgetUrl,
        queryParameters: {
          'date':
              '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}'
        },
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return response.data
        .map<ScheduleModel>((schedule) => ScheduleModel.fromJson(json: schedule))
        .toList();
  }

  Future<String> createSchedule({
    required String accessToken,
    required ScheduleModel schedule,
  }) async {
    final data = schedule.toJson();
    final response = await _dio.post(
      _tartgetUrl,
      data: data,
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return response.data?['id'];
  }

  Future<String> deleteSchedule({
    required String accessToken,
    required String id,
  }) async {
    final response = await _dio.delete(
      _tartgetUrl,
      data: {
        'id': id,
      },
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return response.data?['id'];
  }
}
