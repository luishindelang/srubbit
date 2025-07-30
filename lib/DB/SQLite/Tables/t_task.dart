import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class TTask {
  static const String tableName = "task";
  static const String id = "task_id";
  static const String name = "name";
  static const String onEveryDate = "on_every_date";
  static const String offset = "offset";
  static const String isImportant = "is_important";
  static const String timeFrom = "time_from";
  static const String timeUntil = "time_until";
  static const String taskOwnerId = "task_owner_id";
  static const String repeatingTemplateId = "repeating_template_id";
  static const String doneDate = "done_date";

  static String createTable() {
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $id TEXT PRIMARY KEY,
      $name TEXT NOT NULL,
      $onEveryDate INTEGER NOT NULL,
      $offset INTEGER,
      $isImportant INTEGER NOT NULL,
      $timeFrom INTEGER,
      $timeUntil INTEGER,
      $repeatingTemplateId TEXT,
      $taskOwnerId TEXT,
      $doneDate INTEGER,
      FOREIGN KEY ($taskOwnerId) REFERENCES ${TAccount.tableName}(${TAccount.id}) ON DELETE SET NULL,
      FOREIGN KEY ($repeatingTemplateId) REFERENCES ${TRepeatingTemplates.tableName}(${TRepeatingTemplates.id}) ON DELETE SET NULL
    );
    """;
  }

  static String deleteTable() {
    return "DROP TABLE IF EXISTS $tableName;";
  }
}
