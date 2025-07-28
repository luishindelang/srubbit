import 'package:flutter/material.dart';
import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';
import 'package:sqflite/sqflite.dart';
import 'mappings/mapping_account.dart';

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
    final List<Map<String, dynamic>> result = await db.query(
      TAccount.tableName,
    );
    return fromList(result);
  }

  Future<DsAccount?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return fromMap(result.first);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
    );
  }

}
