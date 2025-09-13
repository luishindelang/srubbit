import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_owner.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_account.dart';

class DaoAccount extends MappingAccount {
  final Database db;
  DaoAccount(this.db);

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
      orderBy: "${TAccount.score} DESC",
    );
    return fromList(rawData);
  }

  Future<DsAccount?> get(String? id) async {
    if (id == null) return null;
    final List<Map<String, dynamic>> rawData = await db.query(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rawData.isEmpty) return null;
    return fromMap(rawData.first);
  }

  Future<List<DsAccount>> getDoneBy(String? taskDateId) async {
    if (taskDateId == null) return [];
    final rawData = await db.rawQuery("""
    SELECT a.* 
    FROM ${TAccount.tableName} a
    LEFT JOIN ${TTaskDoneByAccount.tableName} t
    ON a.${TAccount.id} = t.${TTaskDoneByAccount.accountId}
    WHERE t.${TTaskDoneByAccount.taskDateId} = '$taskDateId';
    """);
    return fromList(rawData);
  }

  Future<List<DsAccount>> getMostDoneBy(int amount) async {
    final rawData = await db.rawQuery("""
    SELECT a.*, COUNT(${TTaskDoneByAccount.taskDateId}) AS tc 
    FROM ${TAccount.tableName} a
    LEFT JOIN ${TTaskDoneByAccount.tableName} t
    ON a.${TAccount.id} = t.${TTaskDoneByAccount.accountId}
    GROUP BY a.${TAccount.id}
    ORDER BY tc DESC
    LIMIT $amount;
    """);
    return fromList(rawData);
  }

  Future<List<DsAccount>> getOwners(String? taskId) async {
    if (taskId == null) return [];
    final rawData = await db.rawQuery("""
    SELECT a.* 
    FROM ${TAccount.tableName} a
    LEFT JOIN ${TTaskOwner.tableName} o
    ON a.${TAccount.id} = o.${TTaskOwner.accountId}
    WHERE o.${TTaskOwner.taskId} = '$taskId';
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
