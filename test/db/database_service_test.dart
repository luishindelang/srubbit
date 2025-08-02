import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';

void main() {
  sqfliteFfiInit();
  late Database db;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await SqlConnection.resetDB(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('init returns singleton', () async {
    final first = await DatabaseService.init();
    final second = await DatabaseService.init();

    expect(identical(first, second), isTrue);
    expect(first.daoAccounts, isNotNull);
    expect(first.daoTasks, isNotNull);
    expect(first.daoRepeatingTemplates, isNotNull);
    expect(first.daoTaskDates, isNotNull);
  });
}
