class TRepeatingTemplates {
  static const String tableName = "repeating_templates";
  static const String id = "id";
  static const String repeatingType = "repeating_type";
  static const String startDate = "start_date";
  static const String endDate = "end_date";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $repeatingType TEXT NOT NULL,
      $startDate INTEGER NOT NULL,
      $endDate INTEGER
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
