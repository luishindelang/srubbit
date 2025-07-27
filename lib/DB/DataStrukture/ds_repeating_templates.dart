import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class DsRepeatingTemplates {
  final String id;
  final String repeatingType;
  final int startDateInt;
  final int? endDateInt;

  const DsRepeatingTemplates({
    required this.id,
    required this.repeatingType,
    required this.startDateInt,
    this.endDateInt,
  });

  factory DsRepeatingTemplates.fromMap(Map<String, dynamic> map) {
    int? toIntOrNull(dynamic value) => value is int ? value : null;

    final repeatingTypeFromMap =
        map[TRepeatingTemplates.repeatingType] as String;

    return DsRepeatingTemplates(
      id: map[TRepeatingTemplates.id] as String,
      repeatingType: repeatingTypeFromMap,
      startDateInt: map[TRepeatingTemplates.startDate] as int,
      endDateInt: toIntOrNull(map[TRepeatingTemplates.endDate]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingTemplates.id: id,
      TRepeatingTemplates.repeatingType: repeatingType,
      TRepeatingTemplates.startDate: startDateInt,
      TRepeatingTemplates.endDate: endDateInt,
    };
  }

  DateTime get startDate => DateTime.fromMillisecondsSinceEpoch(startDateInt);
  DateTime? get endDate =>
      endDateInt != null
          ? DateTime.fromMillisecondsSinceEpoch(endDateInt!)
          : null;
}
