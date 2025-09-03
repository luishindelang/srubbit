import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late DaoTaskDate dao;

  setUp(() async {
    db = await SqlConnection.instance.database;
    await SqlConnection.resetDB(db);
    dao = DaoTaskDate(db);
  });

  tearDown(() async {
    await db.close();
  });
  group("DAO task date", () {
    test('insert and getByTaskId', () async {
      final date = DsTaskDate(
        plannedDate: DateTime(2024, 1, 1),
        task: DsTask(
          name: "name",
          emoji: "emoji",
          onEveryDate: false,
          isImportant: false,
        ),
      );
      await dao.insert(date, 'task1');
    });

    test('update task date', () async {});

    test('deleteByTaskId removes entries', () async {});
  });
}
