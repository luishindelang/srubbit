import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingEveryXDays {
  static const String tableName = "repeating_every_x_days";
  static const String id = "id";
  static const String templateId = "template_id";
  static const String intervalDays = "interval_days";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT  PRIMARY KEY,
      $templateId TEXT,
      $intervalDays INTEGER NOT NULL,
      FOREIGN KEY ($templateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
