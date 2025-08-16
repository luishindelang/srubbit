import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/SQLite/sql_connection.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late DaoRepeatingTemplates dao;

  setUp(() async {
    db = await SqlConnection.instance.database;
    await SqlConnection.resetDB(db);
    dao = DaoRepeatingTemplates(db);
  });

  tearDown(() async {
    await db.close();
  });

  DsRepeatingTemplates buildTemplate() {
    return DsRepeatingTemplates(
      repeatingType: 1,
      repeatingIntervall: 1,
      repeatAfterDone: true,
      startDate: DateTime.utc(2024, 1, 1),
      endDate: null,
    );
  }

  group("DAO repeating template", () {
    test('insert and get', () async {
      final template = buildTemplate();
      await dao.insert(template);
      final fetched = await dao.get(template.id);
      expect(fetched, isNotNull);
      expect(fetched!.repeatingType, TRepeatingTemplates.weekly);
    });

    test('update template', () async {
      final template = buildTemplate();
      await dao.insert(template);

      final updated = template.copyWith(newRepeatingIntervall: 3);
      await dao.update(updated);

      final fetched = await dao.get(template.id);
      expect(fetched!.repeatingIntervall, 3);
    });

    test('getAll lists all templates', () async {
      await dao.insert(buildTemplate());
      await dao.insert(buildTemplate());

      final all = await dao.getAll();
      expect(all.length, 2);
    });

    test('delete removes template', () async {
      final template = buildTemplate();
      await dao.insert(template);
      await dao.delete(template.id);

      final fetched = await dao.get(template.id);
      expect(fetched, isNull);
    });
  });
}
