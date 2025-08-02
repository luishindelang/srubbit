import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  tearDown(() async {
    final db = await SqlConnection.instance.database;
    await db.close();
  });

  test('init returns singleton', () async {
    await SqlConnection.resetDB();

    final first = await DatabaseService.init();
    final second = await DatabaseService.init();

    expect(identical(first, second), isTrue);
    expect(first.daoAccounts, isNotNull);
    expect(first.daoTasks, isNotNull);
    expect(first.daoRepeatingTemplates, isNotNull);
    expect(first.daoTaskDates, isNotNull);
  });
}
