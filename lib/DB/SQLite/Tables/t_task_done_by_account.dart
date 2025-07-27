import 'package:scrubbit/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/DB/Sqlite/Tables/t_accounts.dart';

class TTaskDoneByAccount {
  static const String tableName = "task_done_by_account";
  static const String accountId = "account_id";
  static const String taskId = "task_id";
  static const String doneDate = "done_date";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $accountId TEXT,
      $taskId TEXT,
      $doneDate INTEGER NOT NULL,
      FOREIGN KEY ($accountId) REFERENCES ${TAccounts.tableName}(${TAccounts.id}),
      FOREIGN KEY ($taskId) REFERENCES ${TTask.tableName}(${TTask.id}),
      PRIMARY KEY ($accountId, $taskId)
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
