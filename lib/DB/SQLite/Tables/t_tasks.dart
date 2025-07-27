import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TTasks {
  static const String tableName = "tasks";
  static const String id = "id";
  static const String name = "name";
  static const String plannedDate = "planned_date";
  static const String completionWindowDays = "completion_window_days";
  static const String offset = "offset";
  static const String timeFrom = "time_from";
  static const String timeUntil = "time_until";
  static const String repeatingTemplateId = "repeating_template_id";

  static String createTable() {
    return """
    CREATE TEABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMERY KEY,
      $name TEXT NOT NULL,
      $plannedDate INTEGER NOT NULL,
      $completionWindowDays INTEGER NOT NULL DEFAULT 0,
      $offset INTEGER NOT NULL DEFAULT 0,
      $timeFrom INTEGER,
      $timeUntil INTEGER,
      $repeatingTemplateId TEXT,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
