import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  static Database? _db;
  static final SqlConnection instance = SqlConnection._constructor();

  final String dbName = "mywallet.db";

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

  static Future<void> resetDB() async {
    final db = await SqlConnection.instance.database;
    await deleteTables(db);
    await createTables(db);
  }

  static Future<void> createTables(Database db) async {}

  static Future<void> deleteTables(Database db) async {}
}
