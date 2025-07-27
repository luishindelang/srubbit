import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingYearly {
  static const String tableName = "repeating_yearly";
  static const String repeatingTemplateId = "repeating_template_id";
  static const String month = "month";
  static const String day = "day";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $repeatingTemplateId TEXT PRIMARY KEY,
      $month INTEGER NOT NULL,
      $day INTEGER NOT NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
