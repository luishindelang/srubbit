import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  late Database db;
  late DaoAccount dao;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await SqlConnection.createTables(db);
    dao = DaoAccount(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and get', () async {
    final account = DsAccount(
      name: 'Test',
      color: const Color(0xFFFF0000),
      icon: Icons.add,
    );

    await dao.insert(account);
    final fetched = await dao.get(account.id);

    expect(fetched, isNotNull);
    expect(fetched!.name, 'Test');
  });

  test('update existing account', () async {
    final account = DsAccount(
      name: 'Test',
      color: const Color(0xFF00FF00),
      icon: Icons.add,
    );
    await dao.insert(account);

    final updated = account.copyWith(newName: 'Updated');
    await dao.update(updated);

    final fetched = await dao.get(account.id);
    expect(fetched!.name, 'Updated');
  });

  test('getAll returns all accounts', () async {
    final account1 = DsAccount(
      name: 'A',
      color: const Color(0xFF000000),
      icon: Icons.add,
    );
    final account2 = DsAccount(
      name: 'B',
      color: const Color(0xFFFFFFFF),
      icon: Icons.add,
    );
    await dao.insert(account1);
    await dao.insert(account2);

    final all = await dao.getAll();
    expect(all.length, 2);
  });

  test('delete removes account', () async {
    final account = DsAccount(
      name: 'A',
      color: const Color(0xFF000000),
      icon: Icons.add,
    );
    await dao.insert(account);
    await dao.delete(account.id);

    final fetched = await dao.get(account.id);
    expect(fetched, isNull);
  });
}
