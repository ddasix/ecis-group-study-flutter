import 'dart:async';
import 'dart:io';

import 'package:calendar_schedule/model/schedule_model.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {

  final _dio = Dio();
  //서버 url이 안드로이드내부 인지
  final _targetUrl = "http://${Platform.isAndroid ? "10.0.2.2" : "localhost"}:3000/schedule";

//조회
  Future<List<ScheduleModel>> getSchedules({
    required DateTime date,
}) async {
    final resp = await _dio.get(
      _targetUrl,
     queryParameters: {
       "date": "${date.year}${date.month.toString().padLeft(2, "0")}${date.day.toString().padLeft(2, "0")}"
     });

    //모델 인스턴스로 매핑
    return resp.data.map<ScheduleModel>((x)=>ScheduleModel.fromJson(json: x,),).toList();
  }

  //생성
  Future<String> createSchedule({
    required ScheduleModel schedule,
  }) async {
    final json = schedule.toJson(); //json으로 변환해서 보냄

    final resp = await _dio.post(_targetUrl, data: json);

    return resp.data?["id"];
  }

  //삭제
  Future<String> deleteSchedule({
     required String id,
  }) async {
    final json = await _dio.delete(_targetUrl, data: {"id":id});

    return json.data?["id"];
  }

}