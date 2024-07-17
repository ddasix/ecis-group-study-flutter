import 'package:drift/drift.dart';
import 'package:calendar_schedule/model/schedule.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part "drift_database.g.dart";  // part 파일 지정

@DriftDatabase(  // 사용할 테이블 등록
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {

  LocalDatabase() : super(_openConnection());

  //조회
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  //추가
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  //삭제
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  //테이블 버전
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();  //db 저정 폴더(현재 앱)
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
