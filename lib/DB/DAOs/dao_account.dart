import 'package:flutter/material.dart';
import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';
import 'package:sqflite/sqflite.dart';

class DaoAccount {
  final Database db;
  DaoAccount(this.db);

  Future<void> insert(DsAccount account) async {
    await db.insert(
      TAccount.tableName,
      await _toMap(account),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsAccount account) async {
    await db.update(
      TAccount.tableName,
      await _toMap(account),
      where: '${TAccount.id} = ?',
      whereArgs: [account.id],
    );
  }

  Future<List<DsAccount>> getAll() async {
    final List<Map<String, dynamic>> result = await db.query(
      TAccount.tableName,
    );
    return _fromList(result);
  }

  Future<DsAccount?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return _fromMap(result.first);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TAccount.tableName,
      where: '${TAccount.id} = ?',
      whereArgs: [id],
    );
  }

  // mapper

  Future<DsAccount> _fromMap(Map<String, dynamic> rawData) async {
    return DsAccount(
      id: rawData[TAccount.id],
      name: rawData[TAccount.name],
      color: Color(rawData[TAccount.color]),
      icon: IconData(
        rawData[TAccount.iconCode],
        fontFamily: rawData[TAccount.iconFamily],
      ),
      fromDB: true,
    );
  }

  Future<List<DsAccount>> _fromList(List<Map<String, dynamic>> rawData) async {
    List<DsAccount> finalData = [];
    for (var value in rawData) {
      finalData.add(await _fromMap(value));
    }
    return finalData;
  }

  Future<Map<String, dynamic>> _toMap(DsAccount account) async {
    return {
      TAccount.id: account.id,
      TAccount.name: account.name,
      TAccount.color: account.color.toARGB32(),
      TAccount.iconCode: account.icon.codePoint,
      TAccount.iconFamily: account.icon.fontFamily,
    };
  }
}
