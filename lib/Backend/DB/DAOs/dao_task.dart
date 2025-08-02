import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_task.dart';

class DaoTask extends MappingTask {
  final Database db;
  DaoTask(this.db)
    : super(DaoTaskDate(db), DaoRepeatingTemplates(db), DaoAccount(db));

  Future<void> insert(DsTask task) async {
    await db.insert(
      TTask.tableName,
      await toMap(task),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (task.repeatingTemplate != null) {
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

  Future<DsTask?> get(String id) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTask.tableName,
      where: '${TTask.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rawData.isEmpty) return null;
    return fromMap(rawData.first);
  }

  Future<List<DsTask>> getTaskOwned(String accountId) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTask.tableName,
      where: "${TTask.taskOwnerId} = ?",
      whereArgs: [accountId],
    );
    return fromList(rawData);
  }

  Future<List<DsTask>> getDoneBy(String accountId) async {
    final List<Map<String, dynamic>> rawData = await db.rawQuery("""
    SELECT * FROM ${TTask.tableName} a
    LEFT JOUN ${TTaskDoneByAccount.tableName} t
    ON a.${TTask.id} = t.${TTaskDoneByAccount.taskId}
    WHERE t.${TTaskDoneByAccount.accountId} = $accountId;
    """);
    return fromList(rawData);
  }

  Future<void> delete(String id) async {
    await db.delete(TTask.tableName, where: '${TTask.id} = ?', whereArgs: [id]);
    await daoTaskDate.deleteByTaskId(id);
  }
}
