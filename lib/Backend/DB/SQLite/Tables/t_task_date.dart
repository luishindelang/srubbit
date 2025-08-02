import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';

class TTaskDate {
  static const String tableName = "task_date";
  static const String id = "task_date_id";
  static const String plannedDate = "planned_date";
  static const String completionWindow = "completion_window";
  static const String taskId = "task_id";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $plannedDate INTEGER NOT NULL,
      $completionWindow INTEGER NOT NULL DEFAULT 0,
      $taskId TEXT,
      FOREIGN KEY ($taskId) REFERENCES ${TTask.tableName}(${TTask.id}) ON DELETE SET NULL
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
