import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingMonthly {
  static const String tableName = "repeating_monthly";
  static const String repeatingTemplateId = "repeating_template_id";
  static const String dayOfMonth = "day_of_month";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $repeatingTemplateId TEXT PRIMARY KEY,
      $dayOfMonth INTEGER NOT NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
