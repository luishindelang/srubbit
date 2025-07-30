import 'package:scrubbit/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task_date.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_task_date.dart';

class DaoTaskDate extends MappingTaskDate {
  final Database db;
  DaoTaskDate(this.db);

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
      {
        TTaskDate.plannedDate: taskDate.plannedDate.millisecondsSinceEpoch,
        TTaskDate.completionWindow: taskDate.completionWindow,
      },
      where: '${TTaskDate.id} = ?',
      whereArgs: [taskDate.id],
    );
  }

  Future<List<DsTaskDate>> getByTaskId(String taskId) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [taskId],
    );
    return fromList(rawData);
  }

  Future<void> deleteByTaskId(String taskId) async {
    await db.delete(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [taskId],
    );
  }
}
