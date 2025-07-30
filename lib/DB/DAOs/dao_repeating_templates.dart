import 'package:scrubbit/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';
import 'package:sqflite/sqflite.dart';
import 'Mappings/mapping_repeating_templates.dart';

class DaoRepeatingTemplates extends MappingRepeatingTemplates {
  final Database db;
  DaoRepeatingTemplates(this.db);

  Future<void> insert(DsRepeatingTemplates template) async {
    await db.insert(
      TRepeatingTemplates.tableName,
      toMap(template),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsRepeatingTemplates template) async {
    await db.update(
      TRepeatingTemplates.tableName,
      toMap(template),
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [template.id],
    );
  }

  Future<DsRepeatingTemplates?> get(String id) async {
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
