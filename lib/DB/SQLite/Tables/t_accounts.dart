class TAccounts {
  static const String tableName = "accounts";
  static const String id = "accout_id";
  static const String name = "name";
  static const String color = "farbe";
  static const String iconCode = "icon_code";
  static const String iconFamily = "icon_family";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT NOT NULL,
      $color INTEGER NOT NULL,
      $iconCode INTEGER NOT NULL,
      $iconFamily TEXT NOT NULL
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
