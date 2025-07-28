import 'package:scrubbit/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task_date.dart';
import 'package:sqflite/sqflite.dart';

class DaoTaskDate {
  final Database db;
  DaoTaskDate(this.db);

  Future<void> insert(DsTaskDate taskDate, String taskId) async {
    await db.insert(
      TTaskDate.tableName,
      _toMap(taskDate, taskId),
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
    final List<Map<String, dynamic>> result = await db.query(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [taskId],
    );
    return _fromList(result);
  }

  Future<void> deleteByTaskId(String taskId) async {
    await db.delete(
      TTaskDate.tableName,
      where: '${TTaskDate.taskId} = ?',
      whereArgs: [taskId],
    );
  }

  // mapper

  DsTaskDate _fromMap(Map<String, dynamic> rawData) {
    return DsTaskDate(
      id: rawData[TTaskDate.id],
      plannedDate:
          DateTime.fromMillisecondsSinceEpoch(rawData[TTaskDate.plannedDate]),
      completionWindow: rawData[TTaskDate.completionWindow],
      fromDB: true,
    );
  }

  List<DsTaskDate> _fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(_fromMap).toList();
  }

  Map<String, dynamic> _toMap(DsTaskDate taskDate, String taskId) {
    return {
      TTaskDate.id: taskDate.id,
      TTaskDate.plannedDate: taskDate.plannedDate.millisecondsSinceEpoch,
      TTaskDate.completionWindow: taskDate.completionWindow,
      TTaskDate.taskId: taskId,
    };
  }
}
