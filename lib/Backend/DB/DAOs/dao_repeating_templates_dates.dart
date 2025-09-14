import 'package:scrubbit/Backend/DB/DAOs/Mappings/mapping_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates_dates.dart';
import 'package:sqflite/sqflite.dart';

class DaoRepeatingTemplatesDates extends MappingRepeatingTemplatesDates {
  final Database db;
  DaoRepeatingTemplatesDates(this.db);

  Future<void> insert(
    DsRepeatingTemplatesDates template,
    String repeatingTemplateId,
  ) async {
    await db.insert(
      TRepeatingTemplatesDates.tableName,
      toMap(template, repeatingTemplateId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DsRepeatingTemplatesDates>> getByRepeatingTemplate(
    String repeatingTemplateId,
  ) async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TRepeatingTemplatesDates.tableName,
      where: "${TRepeatingTemplatesDates.repeatingTemplateId} = ?",
      whereArgs: [repeatingTemplateId],
    );
    return fromList(rawData);
  }

  Future<void> deleteByRepeatingTemplate(String id) async {
    await db.delete(
      TRepeatingTemplatesDates.tableName,
      where: '${TRepeatingTemplatesDates.repeatingTemplateId} = ?',
      whereArgs: [id],
    );
  }
}
