import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late DaoTask dao;

  setUp(() async {
    db = await SqlConnection.instance.database;
    await SqlConnection.resetDB(db);
    dao = DaoTask(db);
  });

  tearDown(() async {
    await db.close();
  });

  DsRepeatingTemplates buildTemplate() {
    return DsRepeatingTemplates(
      repeatingType: 1,
      repeatingIntervall: 1,
      repeatAfterDone: true,
      startDate: DateTime.utc(2024, 1, 1),
      endDate: null,
    );
  }

  DsTask buildTask(String name) {
    return DsTask(
      name: 'Task $name',
      emoji: 'test emojy',
      onEveryDate: false,
      taskDates: [],
      offset: 0,
      isImportant: true,
      timeFrom: null,
      timeUntil: null,
      repeatingTemplate: buildTemplate(),
    );
  }

  group("DAO task", () {
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
  });
}
