import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingWeekly {
  static const String tableName = "repeating_weekly";
  static const String repeatingTemplateId = "repeating_template_id";
  static const String weekday = "weekday";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $repeatingTemplateId TEXT PRIMARY KEY,
      $weekday INTEGER NOT NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
