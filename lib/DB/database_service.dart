import 'package:scrubbit/DB/DAOs/dao_accounts.dart';
import 'package:scrubbit/DB/DAOs/dao_tasks.dart';
import 'package:scrubbit/DB/SQLite/sql_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;

  late final DaoAccounts daoAccounts;
  late final DaoTasks daoTasks;

  DatabaseService._(Database db) {
    daoAccounts = DaoAccounts(db);
    daoTasks = DaoTasks();
  }

  static Future<DatabaseService> init() async {
    if (_instance != null) return _instance!;
    final db = await SqlConnection.instance.database;
    _instance = DatabaseService._(db);
    return _instance!;
  }
}
