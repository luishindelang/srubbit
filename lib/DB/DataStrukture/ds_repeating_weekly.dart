import 'package:scrubbit/DB/SQLite/Tables/RepeatingTypes/t_repeating_weekly.dart';

class DsRepeatingWeekly {
  final String id;
  final String templateId;
  final int weekday;

  const DsRepeatingWeekly({
    required this.id,
    required this.templateId,
    required this.weekday,
  });

  factory DsRepeatingWeekly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingWeekly(
      id: map[TRepeatingWeekly.id] as String,
      templateId: map[TRepeatingWeekly.templateId] as String,
      weekday: map[TRepeatingWeekly.weekday] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingWeekly.id: id,
      TRepeatingWeekly.templateId: templateId,
      TRepeatingWeekly.weekday: weekday,
    };
  }
}
