import 'package:scrubbit/DB/SQLite/Tables/t_repeating_weekly.dart';

class DsRepeatingWeekly {
  final String repeatingTemplateId;
  final int weekday;

  const DsRepeatingWeekly({
    required this.repeatingTemplateId,
    required this.weekday,
  });

  factory DsRepeatingWeekly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingWeekly(
      repeatingTemplateId: map[TRepeatingWeekly.repeatingTemplateId] as String,
      weekday: map[TRepeatingWeekly.weekday] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingWeekly.repeatingTemplateId: repeatingTemplateId,
      TRepeatingWeekly.weekday: weekday,
    };
  }
}
