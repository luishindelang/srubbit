import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:scrubbit/DB/DAOs/dao_task.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/DB/SQLite/sql_connection.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

void main() {
  sqfliteFfiInit();
  late Database db;
  late DaoTask dao;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await SqlConnection.createTables(db);
    dao = DaoTask(db);
  });

  tearDown(() async {
    await db.close();
  });

  DsRepeatingTemplates buildTemplate() {
    return DsRepeatingTemplates(
      repeatingType: TRepeatingTemplates.daily,
      repeatingIntervall: 1,
      repeatAfterDone: true,
      startDateInt: DateTime.utc(2024, 1, 1),
      endDateInt: null,
    );
  }

  DsTaskDate buildDate() {
    return DsTaskDate(
      plannedDate: DateTime.utc(2024, 1, 2),
      completionWindow: 0,
    );
  }

  DsTask buildTask(String name) {
    return DsTask(
      name: 'Task $name',
      onEveryDate: false,
      taskDates: [buildDate()],
      offsetDate: null,
      timeFrom: null,
      timeUntil: null,
      repeatingTemplate: buildTemplate(),
      taskOwned: null,
      doneDate: null,
      doneBy: null,
    );
  }

  test('insert and get', () async {
    final task = buildTask('1');
    await dao.insert(task);

    final fetched = await dao.get(task.id);
    expect(fetched, isNotNull);
    expect(fetched!.name, 'Task 1');
    expect(fetched.repeatingTemplate, isNotNull);
    expect(fetched.taskDates.length, 1);
  });

  test('update task', () async {
    final task = buildTask('1');
    await dao.insert(task);

    final updated = task.copyWith(newName: 'Updated');
    await dao.update(updated);

    final fetched = await dao.get(task.id);
    expect(fetched!.name, 'Updated');
  });

  test('getAll returns all tasks', () async {
    await dao.insert(buildTask('1'));
    await dao.insert(buildTask('2'));

    final all = await dao.getAll();
    expect(all.length, 2);
  });

  test('delete removes task', () async {
    final task = buildTask('1');
    await dao.insert(task);
    await dao.delete(task.id);

    final fetched = await dao.get(task.id);
    expect(fetched, isNull);
  });
}
