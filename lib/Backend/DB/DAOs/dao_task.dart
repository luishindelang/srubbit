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

  Future<void> insert(DsTask task) async {
    await db.insert(
      TTask.tableName,
      await toMap(task),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (task.repeatingTemplate != null) {
      await daoRepeatingTemplates.insert(task.repeatingTemplate!);
    }
    for (var newTaskDate in task.taskDates) {
      await daoTaskDate.insert(newTaskDate, task.id);
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
    for (var newTaskDate in task.addTaskDates) {
      await daoTaskDate.insert(newTaskDate, task.id);
    }
    for (var taskDate in task.removedTaskDates) {
      await daoTaskDate.delete(taskDate.id);
    }

    final newTaskDates = [
      ...task.addTaskDates,
      ...task.taskDates,
      ...task.removedTaskDates,
    ];
    newTaskDates.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
    task.update(newTaskDates: newTaskDates);
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

  Future<List<DsTask>> getAllRepeating() async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTask.tableName,
      where: "${TTask.repeatingTemplateId} IS NOT NULL",
    );
    return fromList(rawData);
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

  Future<List<DsTask>> getAllDone() async {
    final List<Map<String, dynamic>> rawData = await db.rawQuery("""
    SELECT * FROM ${TTask.tableName} t
    LEFT JOIN ${TTaskDate.tableName} d
    ON t.${TTask.id} = d.${TTaskDate.taskId}
    WHERE d.${TTaskDate.doneDate} IS NOT NULL;
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
