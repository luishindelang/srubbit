import 'package:scrubbit/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';
import 'package:sqflite/sqflite.dart';

class DaoRepeatingTemplates {
  final Database db;
  DaoRepeatingTemplates(this.db);

  Future<void> insert(DsRepeatingTemplates template) async {
    await db.insert(
      TRepeatingTemplates.tableName,
      _toMap(template),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(DsRepeatingTemplates template) async {
    await db.update(
      TRepeatingTemplates.tableName,
      _toMap(template),
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [template.id],
    );
  }

  Future<DsRepeatingTemplates?> get(String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      TRepeatingTemplates.tableName,
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return _fromMap(result.first);
  }

  Future<List<DsRepeatingTemplates>> getAll() async {
    final List<Map<String, dynamic>> result = await db.query(
      TRepeatingTemplates.tableName,
    );
    return _fromList(result);
  }

  Future<void> delete(String id) async {
    await db.delete(
      TRepeatingTemplates.tableName,
      where: '${TRepeatingTemplates.id} = ?',
      whereArgs: [id],
    );
  }

  // mapper

  DsRepeatingTemplates _fromMap(Map<String, dynamic> rawData) {
    return DsRepeatingTemplates(
      id: rawData[TRepeatingTemplates.id],
      repeatingType: rawData[TRepeatingTemplates.repeatingType],
      repeatingAmount: rawData[TRepeatingTemplates.repeatingAmount],
      startDateInt: DateTime.fromMillisecondsSinceEpoch(
        rawData[TRepeatingTemplates.startDate],
      ),
      endDateInt: rawData[TRepeatingTemplates.endDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              rawData[TRepeatingTemplates.endDate],
            )
          : null,
    );
  }

  List<DsRepeatingTemplates> _fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(_fromMap).toList();
  }

  Map<String, dynamic> _toMap(DsRepeatingTemplates template) {
    return {
      TRepeatingTemplates.id: template.id,
      TRepeatingTemplates.repeatingType: template.repeatingType,
      TRepeatingTemplates.repeatingAmount: template.repeatingAmount,
      TRepeatingTemplates.startDate:
          template.startDateInt.millisecondsSinceEpoch,
      TRepeatingTemplates.endDate:
          template.endDateInt?.millisecondsSinceEpoch,
    };
  }
}
