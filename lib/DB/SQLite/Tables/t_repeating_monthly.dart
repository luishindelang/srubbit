import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingMonthly {
  static const String tableName = "repeating_monthly";
  static const String id = "id";
  static const String templateId = "template_id";
  static const String dayOfMonth = "day_of_month";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $templateId TEXT NOT NULL,
      $dayOfMonth INTEGER NOT NULL CHECK ($dayOfMonth BETWEEN 1 AND 31),
      FOREIGN KEY ($templateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
