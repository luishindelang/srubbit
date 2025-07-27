import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingEveryXIntervall {
  static const String tableName = "repeating_every_x_intervall";
  static const String repeatingTemplateId = "repeating_template_id";
  static const String intervallUnit = "intervall_unit";
  static const String intervallAmount = "intervall_amount";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $repeatingTemplateId TEXT PRIMARY KEY,
      $intervallUnit TEXT NOT NULL
      $intervallAmount INTEGER NOT NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
