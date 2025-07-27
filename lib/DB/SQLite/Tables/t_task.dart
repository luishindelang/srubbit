import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TTask {
  static const String tableName = "task";
  static const String id = "task_id";
  static const String name = "name";
  static const String plannedDate = "planned_date";
  static const String completionWindow = "completion_window";
  static const String offsetDate = "offset_date";
  static const String timeFrom = "time_from";
  static const String timeUntil = "time_until";
  static const String taskOwnderId = "task_owner_id";
  static const String repeatingTemplateId = "repeating_template_id";

  static String createTable() {
    return """
    CREATE TEABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMERY KEY,
      $name TEXT NOT NULL,
      $plannedDate INTEGER NOT NULL,
      $completionWindow INTEGER NOT NULL DEFAULT 0,
      $offsetDate INTEGER,
      $timeFrom INTEGER,
      $timeUntil INTEGER,
      $repeatingTemplateId TEXT,
      $taskOwnderId TEXT,
      FOREIGN KEY ($taskOwnderId) REFERENCES ${TAccount.tableName}(${TAccount.id}) ON DELETE SET NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id}) ON DELETE SET NULL
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
