import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingWeekly {
  static const String tableName = "repeating_weekly";
  static const String id = "id";
  static const String templateId = "template_id";
  static const String weekday = "weekday";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $templateId TEXT NOT NULL,
      $weekday INTEGER NOT NULL CHECK ($weekday BETWEEN 1 AND 7),
      FOREIGN KEY ($templateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
