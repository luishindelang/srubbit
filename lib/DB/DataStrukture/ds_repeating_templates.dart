import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class DsRepeatingTemplates {
  final String id;
  final String name;
  final int startDateInt;
  final int completionWindowDays;
  final int? timeFromInt;
  final int? timeUntilInt;
  final String repeatType;

  const DsRepeatingTemplates({
    required this.id,
    required this.name,
    required this.startDateInt,
    required this.completionWindowDays,
    this.timeFromInt,
    this.timeUntilInt,
    required this.repeatType,
  });

  factory DsRepeatingTemplates.fromMap(Map<String, dynamic> map) {
    int? toIntOrNull(dynamic value) => value is int ? value : null;

    return DsRepeatingTemplates(
      id: map[TRepeatingTemplates.id] as String,
      name: map[TRepeatingTemplates.name] as String,
      startDateInt: map[TRepeatingTemplates.startDate] as int,
      completionWindowDays:
          map[TRepeatingTemplates.completionWindowDays] as int,
      timeFromInt: toIntOrNull(map[TRepeatingTemplates.timeFrom]),
      timeUntilInt: toIntOrNull(map[TRepeatingTemplates.timeUntil]),
      repeatType: map[TRepeatingTemplates.repeatType] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingTemplates.id: id,
      TRepeatingTemplates.name: name,
      TRepeatingTemplates.startDate: startDateInt,
      TRepeatingTemplates.completionWindowDays: completionWindowDays,
      TRepeatingTemplates.timeFrom: timeFromInt,
      TRepeatingTemplates.timeUntil: timeUntilInt,
      TRepeatingTemplates.repeatType: repeatType,
    };
  }

  DateTime get startDate =>
      DateTime.fromMillisecondsSinceEpoch(startDateInt);
  DateTime? get timeFrom => timeFromInt != null
      ? DateTime.fromMillisecondsSinceEpoch(timeFromInt!)
      : null;
  DateTime? get timeUntil => timeUntilInt != null
      ? DateTime.fromMillisecondsSinceEpoch(timeUntilInt!)
      : null;
}
