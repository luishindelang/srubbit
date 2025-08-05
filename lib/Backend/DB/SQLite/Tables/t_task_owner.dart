import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_account.dart';

class TTaskOwner {
  static const String tableName = "task_owner";
  static const String id = "task_owner_id";
  static const String accountId = "account_id";
  static const String taskId = "task_id";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id PRIMARY KEY,
      $accountId TEXT,
      $taskId TEXT,
      FOREIGN KEY ($accountId) REFERENCES ${TAccount.tableName}(${TAccount.id}),
      FOREIGN KEY ($taskId) REFERENCES ${TTask.tableName}(${TTask.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
