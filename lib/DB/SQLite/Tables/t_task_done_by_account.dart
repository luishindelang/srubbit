import 'package:scrubbit/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';

class TTaskDoneByAccount {
  static const String tableName = "task_done_by_account";
  static const String accountId = "account_id";
  static const String taskId = "task_id";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $accountId TEXT,
      $taskId TEXT,
      FOREIGN KEY ($accountId) REFERENCES ${TAccount.tableName}(${TAccount.id}),
      FOREIGN KEY ($taskId) REFERENCES ${TTask.tableName}(${TTask.id}),
      PRIMARY KEY ($accountId, $taskId)
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
