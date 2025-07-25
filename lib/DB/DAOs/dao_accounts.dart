import 'package:scrubbit/DB/DataStrukture/ds_accounts.dart';
import 'package:scrubbit/DB/Sqlite/Tables/t_accounts.dart';
import 'package:sqflite/sqflite.dart';

class DaoAccounts {
  final Database db;
  DaoAccounts(this.db);

  Future<void> insert(DsAccount account) async {
    await db.insert(
      TAccounts.tableName,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsAccount account) async {
    await db.update(
      TAccounts.tableName,
      account.toMap(),
      where: '${TAccounts.id} = ?',
      whereArgs: [account.id],
    );
  }

  Future<List<DsAccount>> getAll() async {
    final List<Map<String, dynamic>> result = await db.query(
      TAccounts.tableName,
    );
    return result.map((map) => DsAccount.fromMap(map)).toList();
  }

  Future<DsAccount?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TAccounts.tableName,
      where: '${TAccounts.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return DsAccount.fromMap(result.first);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TAccounts.tableName,
      where: '${TAccounts.id} = ?',
      whereArgs: [id],
    );
  }
}
