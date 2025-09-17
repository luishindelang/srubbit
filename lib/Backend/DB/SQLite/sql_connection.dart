import 'package:path/path.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_done_by_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_owner.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  static Database? _db;
  static final SqlConnection instance = SqlConnection._constructor();

  final String dbName = "srubbit.db";

  SqlConnection._constructor();

  Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;
    _db = await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, dbName);
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        createTables(db);
      },
    );
    return database;
  }

  static Future<void> resetDB(db) async {
    await deleteTables(db);
    await createTables(db);
  }

  static Future<void> createTables(Database db) async {
    await db.execute(TAccount.createTable());
    await db.execute(TRepeatingTemplates.createTable());
    await db.execute(TTask.createTable());
    await db.execute(TTaskDate.createTable());
    await db.execute(TTaskDoneByAccount.createTable());
    await db.execute(TTaskOwner.createTable());
    await db.execute(TRepeatingTemplatesDates.createTable());
  }

  static Future<void> deleteTables(Database db) async {
    await db.execute(TTaskOwner.deleteTable());
    await db.execute(TTaskDoneByAccount.deleteTable());
    await db.execute(TTaskDate.deleteTable());
    await db.execute(TTask.deleteTable());
    await db.execute(TRepeatingTemplates.deleteTable());
    await db.execute(TAccount.deleteTable());
    await db.execute(TRepeatingTemplatesDates.deleteTable());
  }
}
