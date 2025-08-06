import 'package:scrubbit/Backend/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';

class TTaskDoneByAccount {
  static const String tableName = "task_done_by_account";
  static const String accountId = "account_id";
  static const String taskDateId = "task_date_id";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $accountId TEXT,
      $taskDateId TEXT,
      FOREIGN KEY ($accountId) REFERENCES ${TAccount.tableName}(${TAccount.id}),
      FOREIGN KEY ($taskDateId) REFERENCES ${TTaskDate.tableName}(${TTaskDate.id}),
      PRIMARY KEY ($accountId, $taskDateId)
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
