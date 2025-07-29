class TRepeatingTemplates {
  static const String tableName = "repeating_templates";
  static const String id = "repeating_templates_id";
  static const String repeatingType = "repeating_type";
  static const String repeatingIntervall = "repeating_intervall";
  static const String repeatingCount = "repeating_count";
  static const String repeatAfterDone = "repeat_after_done";
  static const String startDate = "start_date";
  static const String endDate = "end_date";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $repeatingType TEXT NOT NULL CHECK (
        $repeatingType IN ('$daily','$weekly', '$monthly', '$yearly')
      ),
      $repeatingIntervall INTEGER NOT NULL,
      $repeatingCount INTEGER,
      $repeatAfterDone INTEGER NOT NULL,
      $startDate INTEGER NOT NULL,
      $endDate INTEGER
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }

  // repeating types

  static const String daily = "daily";
  static const String weekly = "weekly";
  static const String monthly = "monthly";
  static const String yearly = "yearly";
}
