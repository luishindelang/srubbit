import 'package:scrubbit/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task.dart';
import 'package:sqflite/sqflite.dart';

class DaoTask {
  final Database db;
  late final DaoTaskDate _daoTaskDate;
  late final DaoRepeatingTemplates _daoRepeatingTemplates;

  DaoTask(this.db) {
    _daoTaskDate = DaoTaskDate(db);
    _daoRepeatingTemplates = DaoRepeatingTemplates(db);
  }

  Future<void> insert(DsTask task) async {
    if (task.repeatingTemplate != null) {
      await _daoRepeatingTemplates.insert(task.repeatingTemplate!);
    }
    await db.insert(
      TTask.tableName,
      await _toMap(task),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (final date in task.taskDates) {
      await _daoTaskDate.insert(date, task.id);
    }
  }

  Future<void> update(DsTask task) async {
    if (task.repeatingTemplate != null) {
      await _daoRepeatingTemplates.update(task.repeatingTemplate!);
    }
    await db.update(
      TTask.tableName,
      await _toMap(task),
      where: '${TTask.id} = ?',
      whereArgs: [task.id],
    );
    await _daoTaskDate.deleteByTaskId(task.id);
    for (final date in task.taskDates) {
      await _daoTaskDate.insert(date, task.id);
    }
  }

  Future<List<DsTask>> getAll() async {
    final List<Map<String, dynamic>> result = await db.query(TTask.tableName);
    return _fromList(result);
  }

  Future<DsTask?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TTask.tableName,
      where: '${TTask.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return _fromMap(result.first);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TTask.tableName,
      where: '${TTask.id} = ?',
      whereArgs: [id],
    );
    await _daoTaskDate.deleteByTaskId(id);
  }

  // mapper

  Future<DsTask> _fromMap(Map<String, dynamic> rawData) async {
    final repeatingTemplateId = rawData[TTask.repeatingTemplateId] as String?;
    final repeatingTemplate = repeatingTemplateId != null
        ? await _daoRepeatingTemplates.get(repeatingTemplateId)
        : null;
    final taskDates = await _daoTaskDate.getByTaskId(rawData[TTask.id]);

    return DsTask(
      id: rawData[TTask.id],
      name: rawData[TTask.name],
      onEveryDate: rawData[TTask.onEveryDate] == 1,
      taskDates: taskDates,
      offsetDate: rawData[TTask.offsetDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.offsetDate])
          : null,
      timeFrom: rawData[TTask.timeFrom] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeFrom])
          : null,
      timeUntil: rawData[TTask.timeUntil] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeUntil])
          : null,
      repeatingTemplate: repeatingTemplate,
      doneDate: null,
      doneBy: null,
      fromDB: true,
    );
  }

  Future<List<DsTask>> _fromList(List<Map<String, dynamic>> rawData) async {
    List<DsTask> finalData = [];
    for (var value in rawData) {
      finalData.add(await _fromMap(value));
    }
    return finalData;
  }

  Future<Map<String, dynamic>> _toMap(DsTask task) async {
    return {
      TTask.id: task.id,
      TTask.name: task.name,
      TTask.onEveryDate: task.onEveryDate ? 1 : 0,
      TTask.offsetDate: task.offsetDate?.millisecondsSinceEpoch,
      TTask.timeFrom: task.timeFrom?.millisecondsSinceEpoch,
      TTask.timeUntil: task.timeUntil?.millisecondsSinceEpoch,
      TTask.repeatingTemplateId: task.repeatingTemplate?.id,
      TTask.taskOwnderId: null,
    };
  }
}
