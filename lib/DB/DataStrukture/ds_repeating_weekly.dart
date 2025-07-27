import 'package:scrubbit/DB/SQLite/Tables/t_repeating_weekly.dart';

class DsRepeatingWeekly {
  final String id;
  final String repeatingTemplateId;
  final int weekday;

  const DsRepeatingWeekly({
    required this.id,
    required this.repeatingTemplateId,
    required this.weekday,
  });

  factory DsRepeatingWeekly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingWeekly(
      id: map[TRepeatingWeekly.id] as String,
      repeatingTemplateId: map[TRepeatingWeekly.repeatingTemplateId] as String,
      weekday: map[TRepeatingWeekly.weekday] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingWeekly.id: id,
      TRepeatingWeekly.repeatingTemplateId: repeatingTemplateId,
      TRepeatingWeekly.weekday: weekday,
    };
  }
}
