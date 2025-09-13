import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_task_date.dart';

class DaoTaskDate extends MappingTaskDate {
  final Database db;
  DaoTaskDate(this.db) : super(DaoAccount(db));

  Future<void> insert(DsTaskDate taskDate, String taskId) async {
    await db.insert(
      TTaskDate.tableName,
      toMap(taskDate, taskId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsTaskDate taskDate) async {
    await db.update(
      TTaskDate.tableName,
      toMap(taskDate, taskDate.task.id),
      where: '${TTaskDate.id} = ?',
      whereArgs: [taskDate.id],
    );
    if (taskDate.doneBy != null) {
      for (var account in taskDate.doneBy!) {
        await db.delete(
          TTaskDoneByAccount.tableName,
          where:
              "${TTaskDoneByAccount.taskDateId} = ? AND ${TTaskDoneByAccount.accountId} = ?",
          whereArgs: [taskDate.id, account.id],
        );
        await db.insert(TTaskDoneByAccount.tableName, {
          TTaskDoneByAccount.taskDateId: taskDate.id,
          TTaskDoneByAccount.accountId: account.id,
        });
      }
    }
  }

  Future<List<DsTaskDate>> getByTask(DsTask task) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [task.id],
    );
    return fromList(rawData, task);
  }

  Future<DateTime?> getLastDoneDateByTaskId(DsTask task) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTaskDate.tableName,
      where: "${TTaskDate.taskId} = ?",
      whereArgs: [task.id],
      orderBy: "${TTaskDate.plannedDate} ASC",
    );
    if (rawData.isEmpty) return null;
    final taskDate = await fromMap(rawData.first, task);
    return taskDate.plannedDate;
  }

  Future<void> deleteByTaskId(String taskId) async {
    await db.delete(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> delete(String id) async {
    await db.delete(
      TTaskDate.tableName,
      where: '${TTaskDate.id} = ?',
      whereArgs: [id],
    );
  }
}
