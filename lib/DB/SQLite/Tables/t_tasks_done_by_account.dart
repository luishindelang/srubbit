import 'package:scrubbit/DB/SQLite/Tables/t_tasks.dart';
import 'package:scrubbit/DB/Sqlite/Tables/t_accounts.dart';

class TTasksDoneByAccount {
  static const String tableName = "tasks_done_by_account";
  static const String accountId = "account_id";
  static const String taskId = "task_id";
  static const String doneDate = "done_date";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $accountId TEXT PRIMARY KEY,
      $taskId TEXT PRIMARY KEY,
      $doneDate INTEGER NOT NULL,
      FOREIGN KEY ($accountId) REFERENCES ${TAccounts.tableName}(${TAccounts.id}),
      FOREIGN KEY ($taskId) REFERENCES ${TTasks.tableName}(${TTasks.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
