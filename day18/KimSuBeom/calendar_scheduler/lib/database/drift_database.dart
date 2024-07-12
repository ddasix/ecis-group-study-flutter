import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(tables: [
  Schedule,
])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<List<ScheduleData>> watchSchedules(DateTime date) =>
      (select(schedule)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createSchedule(ScheduleCompanion data) =>
      into(schedule).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(schedule)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
