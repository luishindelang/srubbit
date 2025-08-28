import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_owner.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_task.dart';

class DaoTask extends MappingTask {
  final Database db;
  DaoTask(this.db)
    : super(DaoTaskDate(db), DaoRepeatingTemplates(db), DaoAccount(db));

  Future<void> insert(DsTask task, {bool isNewRepeatingTask = false}) async {
    await db.insert(
      TTask.tableName,
      await toMap(task),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (task.repeatingTemplate != null && !isNewRepeatingTask) {
      await daoRepeatingTemplates.insert(task.repeatingTemplate!);
    }
    for (final date in task.taskDates) {
      await daoTaskDate.insert(date, task.id);
    }
  }

  Future<void> update(DsTask task) async {
    await db.update(
      TTask.tableName,
      await toMap(task),
      where: '${TTask.id} = ?',
      whereArgs: [task.id],
    );
    if (task.repeatingTemplate != null) {
      await daoRepeatingTemplates.update(task.repeatingTemplate!);
    }
    await daoTaskDate.deleteByTaskId(task.id);
    for (final date in task.taskDates) {
      await daoTaskDate.insert(date, task.id);
    }
  }

  Future<List<DsTask>> getAll() async {
    final List<Map<String, dynamic>> rawData = await db.query(TTask.tableName);
    return fromList(rawData);
  }

  Future<DsTask?> get(String? id) async {
    if (id == null) return null;
    final List<Map<String, dynamic>> rawData = await db.query(
      TTask.tableName,
      where: '${TTask.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rawData.isEmpty) return null;
    return fromMap(rawData.first);
  }

  Future<List<DsTask>> getTaskOwned(String? accountId) async {
    final List<Map<String, dynamic>> rawData = await db.rawQuery("""
    SELECT * FROM ${TTask.tableName} t
    LEFT JOIN ${TTaskOwner.tableName} o
    ON t.${TTask.id} = o.${TTaskOwner.taskId}
    WHERE o.${TTaskOwner.accountId} = '$accountId';
    """);
    return fromList(rawData);
  }

  Future<List<DsTask>> getDoneBy(String accountId) async {
    final List<Map<String, dynamic>> rawData = await db.rawQuery("""
    SELECT * FROM ${TTask.tableName} a
    LEFT JOIN ${TTaskDate.tableName} d
    ON a.${TTask.id} = d.${TTaskDate.taskId}
    LEFT JOIN ${TTaskDoneByAccount.tableName} t
    ON d.${TTaskDate.id} = t.${TTaskDoneByAccount.taskDateId}
    WHERE t.${TTaskDoneByAccount.accountId} = '$accountId';
    """);
    return fromList(rawData);
  }

  Future<void> delete(String id) async {
    await db.delete(TTask.tableName, where: '${TTask.id} = ?', whereArgs: [id]);
    await daoTaskDate.deleteByTaskId(id);
  }
}
