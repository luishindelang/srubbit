import 'package:scrubbit/DB/DAOs/dao_task.dart';
import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_account.dart';

class DaoAccount extends MappingAccount {
  final Database db;
  DaoAccount(this.db) : super(DaoTask(db));

  Future<void> insert(DsAccount account) async {
    await db.insert(
      TAccount.tableName,
      toMap(account),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsAccount account) async {
    await db.update(
      TAccount.tableName,
      toMap(account),
      where: '${TAccount.id} = ?',
      whereArgs: [account.id],
    );
  }

  Future<List<DsAccount>> getAll() async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TAccount.tableName,
    );
    return fromList(rawData);
  }

  Future<DsAccount?> get(String id) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rawData.isEmpty) return null;
    return fromMap(rawData.first);
  }

  Future<List<DsAccount>> getDoneBy(String taskId) async {
    final rawData = await db.rawQuery("""
    SELECT * FROM ${TAccount.tableName} a
    LEFT JOUN ${TTaskDoneByAccount.tableName} t
    ON a.${TAccount.id} = t.${TTaskDoneByAccount.accountId}
    WHERE t.${TTaskDoneByAccount.taskId} = $taskId;
    """);
    return fromList(rawData);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
    );
  }
}
