import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_repeating_templates.dart';

class DaoRepeatingTemplates extends MappingRepeatingTemplates {
  final Database db;
  DaoRepeatingTemplates(this.db) : super(DaoRepeatingTemplatesDates(db));

  Future<void> insert(DsRepeatingTemplates template) async {
    await db.insert(
      TRepeatingTemplates.tableName,
      toMap(template),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (var dates in template.repeatingDates) {
      await daoRepeatingTemplatesDates.insert(dates, template.id);
    }
  }

  Future<void> update(DsRepeatingTemplates template) async {
    await db.update(
      TRepeatingTemplates.tableName,
      toMap(template),
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [template.id],
    );
    await daoRepeatingTemplatesDates.deleteByRepeatingTemplate(template.id);
    for (var dates in template.repeatingDates) {
      await daoRepeatingTemplatesDates.insert(dates, template.id);
    }
  }

  Future<DsRepeatingTemplates?> get(String? id) async {
    if (id == null) return null;
    final List<Map<String, dynamic>> rawData = await db.query(
      TRepeatingTemplates.tableName,
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rawData.isEmpty) return null;
    return fromMap(rawData.first);
  }

  Future<List<DsRepeatingTemplates>> getAll() async {
    final List<Map<String, dynamic>> rawData = await db.query(
      TRepeatingTemplates.tableName,
    );
    return fromList(rawData);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TRepeatingTemplates.tableName,
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [id],
    );
  }
}
