import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';

class TRepeatingTemplatesDates {
  static const String tableName = "repeating_templates_dates";
  static const String id = "repeating_templates_dates_id";
  static const String month = "month";
  static const String monthDay = "month_day";
  static const String weekDay = "week_day";
  static const String repeatingTemplateId = "repeating_template_id";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $month INTEGER NOT NULL,
      $monthDay INTEGER NOT NULL,
      $weekDay INTEGER NOT NULL,
      $repeatingTemplateId TEXT NOT NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id})
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName";
  }
}
