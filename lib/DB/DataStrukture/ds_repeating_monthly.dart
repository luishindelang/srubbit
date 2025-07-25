import 'package:scrubbit/DB/SQLite/Tables/RepeatingTypes/t_repeating_monthly.dart';

class DsRepeatingMonthly {
  final String id;
  final String templateId;
  final int dayOfMonth;

  const DsRepeatingMonthly({
    required this.id,
    required this.templateId,
    required this.dayOfMonth,
  });

  factory DsRepeatingMonthly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingMonthly(
      id: map[TRepeatingMonthly.id] as String,
      templateId: map[TRepeatingMonthly.templateId] as String,
      dayOfMonth: map[TRepeatingMonthly.dayOfMonth] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingMonthly.id: id,
      TRepeatingMonthly.templateId: templateId,
      TRepeatingMonthly.dayOfMonth: dayOfMonth,
    };
  }
}
