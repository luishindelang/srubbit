class TRepeatingTemplates {
  static const String tableName = "repeating_templates";

  static const String id = "id";
  static const String name = "name";
  static const String startDate = "start_date";
  static const String completionWindowDays = "completion_window_days";
  static const String timeFrom = "time_from";
  static const String timeUntil = "time_until";
  static const String repeatType = "repeat_type";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT NOT NULL,
      $startDate INTEGER NOT NULL,
      $completionWindowDays INTEGER NOT NULL DEFAULT 0
      $timeFrom INTEGER,
      $timeUntil INTEGER,
      $repeatType TEXT NOT NULL,
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
