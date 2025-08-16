import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';

class MappingRepeatingTemplates {
  DsRepeatingTemplates fromMap(Map<String, dynamic> rawData) {
    return DsRepeatingTemplates(
      id: rawData[TRepeatingTemplates.id],
      repeatingType: rawData[TRepeatingTemplates.repeatingType],
      repeatingIntervall: rawData[TRepeatingTemplates.repeatingIntervall],
      repeatingCount: rawData[TRepeatingTemplates.repeatingCount],
      repeatAfterDone: rawData[TRepeatingTemplates.repeatAfterDone] == 1,
      startDate: DateTime.fromMillisecondsSinceEpoch(
        rawData[TRepeatingTemplates.startDate],
      ),
      endDate:
          rawData[TRepeatingTemplates.endDate] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                rawData[TRepeatingTemplates.endDate],
              )
              : null,
    );
  }

  List<DsRepeatingTemplates> fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(fromMap).toList();
  }

  Map<String, dynamic> toMap(DsRepeatingTemplates template) {
    return {
      TRepeatingTemplates.id: template.id,
      TRepeatingTemplates.repeatingType: template.repeatingType,
      TRepeatingTemplates.repeatingIntervall: template.repeatingIntervall,
      TRepeatingTemplates.repeatingCount: template.repeatingCount,
      TRepeatingTemplates.repeatAfterDone: template.repeatAfterDone ? 1 : 0,
      TRepeatingTemplates.startDate: template.startDate.millisecondsSinceEpoch,
      TRepeatingTemplates.endDate: template.endDate?.millisecondsSinceEpoch,
    };
  }
}
