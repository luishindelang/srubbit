import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  late Database db;
  late DaoTaskDate dao;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await SqlConnection.createTables(db);
    dao = DaoTaskDate(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and getByTaskId', () async {
    final date = DsTaskDate(
      plannedDate: DateTime(2024, 1, 1),
      completionWindow: 0,
    );
    await dao.insert(date, 'task1');

    final fetched = await dao.getByTaskId('task1');
    expect(fetched.length, 1);
    expect(fetched.first.plannedDate, date.plannedDate);
  });

  test('update task date', () async {
    final date = DsTaskDate(
      plannedDate: DateTime.utc(2024, 1, 1),
      completionWindow: 0,
    );
    await dao.insert(date, 'task1');
    final updated = date.copyWith(newCompletionWindow: 5);
    await dao.update(updated);

    final fetched = await dao.getByTaskId('task1');
    expect(fetched.first.completionWindow, 5);
  });

  test('deleteByTaskId removes entries', () async {
    final date = DsTaskDate(
      plannedDate: DateTime.utc(2024, 1, 1),
      completionWindow: 0,
    );
    await dao.insert(date, 'task1');
    await dao.deleteByTaskId('task1');

    final fetched = await dao.getByTaskId('task1');
    expect(fetched, isEmpty);
  });
}
