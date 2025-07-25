import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingYearly {
  static const String tableName = "repeating_yearly";
  static const String id = "id";
  static const String templateId = "template_id";
  static const String month = "month";
  static const String day = "day";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $templateId TEXT NOT NULL,
      $month INTEGER NOT NULL,
      $day INTEGER NOT NULL,
      FOREIGN KEY ($templateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
