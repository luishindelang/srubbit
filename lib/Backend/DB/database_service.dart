import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  List<DsAccount> _accounts = [];

  List<DsAccount> get getAccounts => _accounts;

  set setAccounts(List<DsAccount> newAccounts) => _accounts = newAccounts;

  void addAccount(DsAccount newAccount) {
    _accounts.add(newAccount);
  }

  void deleteAccount(DsAccount account) {
    _accounts.remove(account);
  }

  late final DaoAccount daoAccounts;
  late final DaoTask daoTasks;
  late final DaoTaskDate daoTaskDates;
  late final DaoRepeatingTemplates daoRepeatingTemplates;

  DatabaseService._(Database db) {
    daoAccounts = DaoAccount(db);
    daoTaskDates = DaoTaskDate(db);
    daoRepeatingTemplates = DaoRepeatingTemplates(db);
    daoTasks = DaoTask(db);
  }

  static Future<DatabaseService> init() async {
    if (_instance != null) return _instance!;
    final db = await SqlConnection.instance.database;
    _instance = DatabaseService._(db);
    return _instance!;
  }

  Future<void> loadAccounts() async {
    _accounts = await daoAccounts.getAll();
  }
}
