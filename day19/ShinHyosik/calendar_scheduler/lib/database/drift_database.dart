import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;

import 'package:calendar_scheduler/models/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    },
  );
}

@DriftDatabase(
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Schedule>> watchSchedules(DateTime date) {
    return (select(schedules)
          ..where(
            (tbl) => tbl.date.equals(date),
          ))
        .watch();
  }

  Future<int> createSchedule(SchedulesCompanion data) {
    return into(schedules).insert(data);
  }

  Future<int> removeSchdule(int id) {
    return (delete(schedules)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }
}
