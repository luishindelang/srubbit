import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class DsRepeatingTemplates {
  final String id;
  final String name;
  final int startDateInt;
  final int completionWindowDays;
  final String repeatType;
  final int? timeFromInt;
  final int? timeUntilInt;

  const DsRepeatingTemplates({
    required this.id,
    required this.name,
    required this.startDateInt,
    required this.completionWindowDays,
    required this.repeatType,
    this.timeFromInt,
    this.timeUntilInt,
  });

  factory DsRepeatingTemplates.fromMap(Map<String, dynamic> map) {
    int? toIntOrNull(dynamic value) => value is int ? value : null;

    return DsRepeatingTemplates(
      id: map[TRepeatingTemplates.id] as String,
      name: map[TRepeatingTemplates.name] as String,
      startDateInt: map[TRepeatingTemplates.startDate] as int,
      completionWindowDays:
          map[TRepeatingTemplates.completionWindowDays] as int,
      repeatType: map[TRepeatingTemplates.repeatType] as String,
      timeFromInt: toIntOrNull(map[TRepeatingTemplates.timeFrom]),
      timeUntilInt: toIntOrNull(map[TRepeatingTemplates.timeUntil]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingTemplates.id: id,
      TRepeatingTemplates.name: name,
      TRepeatingTemplates.startDate: startDateInt,
      TRepeatingTemplates.completionWindowDays: completionWindowDays,
      TRepeatingTemplates.repeatType: repeatType,
      TRepeatingTemplates.timeFrom: timeFromInt,
      TRepeatingTemplates.timeUntil: timeUntilInt,
    };
  }

  DateTime get startDate => DateTime.fromMillisecondsSinceEpoch(startDateInt);
  DateTime? get timeFrom =>
      timeFromInt != null
          ? DateTime.fromMillisecondsSinceEpoch(timeFromInt!)
          : null;
  DateTime? get timeUntil =>
      timeUntilInt != null
          ? DateTime.fromMillisecondsSinceEpoch(timeUntilInt!)
          : null;
}
