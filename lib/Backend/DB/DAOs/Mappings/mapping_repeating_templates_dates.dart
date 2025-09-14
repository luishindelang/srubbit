import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates_dates.dart';

class MappingRepeatingTemplatesDates {
  DsRepeatingTemplatesDates fromMap(Map<String, dynamic> rawData) {
    return DsRepeatingTemplatesDates(
      id: rawData[TRepeatingTemplatesDates.id] as String,
      month: rawData[TRepeatingTemplatesDates.month] as int,
      monthDay: rawData[TRepeatingTemplatesDates.monthDay] as int,
      weekDay: rawData[TRepeatingTemplatesDates.weekDay] as int,
    );
  }

  List<DsRepeatingTemplatesDates> fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(fromMap).toList();
  }

  Map<String, dynamic> toMap(
    DsRepeatingTemplatesDates template,
    String repeatingTemplateId,
  ) {
    return {
      TRepeatingTemplatesDates.id: template.id,
      TRepeatingTemplatesDates.month: template.month,
      TRepeatingTemplatesDates.monthDay: template.monthDay,
      TRepeatingTemplatesDates.weekDay: template.weekDay,
      TRepeatingTemplatesDates.repeatingTemplateId: repeatingTemplateId,
    };
  }
}
