import 'package:scrubbit/DB/DAOs/dao_account.dart';
import 'package:scrubbit/DB/SQLite/sql_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;

  late final DaoAccount daoAccounts;

  DatabaseService._(Database db) {
    daoAccounts = DaoAccount(db);
  }

  static Future<DatabaseService> init() async {
    if (_instance != null) return _instance!;
    final db = await SqlConnection.instance.database;
    _instance = DatabaseService._(db);
    return _instance!;
  }
}
