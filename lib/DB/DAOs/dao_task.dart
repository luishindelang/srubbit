import 'package:scrubbit/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_task.dart';

class DaoTask extends MappingTask {
  final Database db;
  DaoTask(this.db) : super(DaoTaskDate(db), DaoRepeatingTemplates(db));

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
    final List<Map<String, dynamic>> result = await db.query(TTask.tableName);
    return fromList(result);
  }

  Future<DsTask?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TTask.tableName,
      where: '${TTask.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<void> delete(String id) async {
    await db.delete(TTask.tableName, where: '${TTask.id} = ?', whereArgs: [id]);
    await daoTaskDate.deleteByTaskId(id);
  }
}
