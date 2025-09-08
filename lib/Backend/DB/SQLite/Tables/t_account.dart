class TAccount {
  static const String tableName = "account";
  static const String id = "account_id";
  static const String name = "name";
  static const String color = "farbe";
  static const String score = "score";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT NOT NULL,
      $color INTEGER NOT NULL,
      $score INTEGER
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
