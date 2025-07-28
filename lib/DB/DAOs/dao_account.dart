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
      _toMap(account),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsAccount account) async {
    await db.update(
      TAccount.tableName,
      _toMap(account),
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

  DsAccount _fromMap(Map<String, dynamic> rawData) {
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

  List<DsAccount> _fromList(List<Map<String, dynamic>> rawData) {
    List<DsAccount> finalData = [];
    for (var value in rawData) {
      finalData.add(_fromMap(value));
    }
    return finalData;
  }

  Map<String, dynamic> _toMap(DsAccount account) {
    return {
      TAccount.id: account.id,
      TAccount.name: account.name,
      TAccount.color: account.color.toARGB32(),
      TAccount.iconCode: account.icon.codePoint,
      TAccount.iconFamily: account.icon.fontFamily,
    };
  }
}
