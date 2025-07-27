import 'package:scrubbit/DB/SQLite/Tables/t_repeating_monthly.dart';

class DsRepeatingMonthly {
  final String id;
  final String repeatingTemplateId;
  final int dayOfMonth;

  const DsRepeatingMonthly({
    required this.id,
    required this.repeatingTemplateId,
    required this.dayOfMonth,
  });

  factory DsRepeatingMonthly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingMonthly(
      id: map[TRepeatingMonthly.id] as String,
      repeatingTemplateId: map[TRepeatingMonthly.repeatingTemplateId] as String,
      dayOfMonth: map[TRepeatingMonthly.dayOfMonth] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingMonthly.id: id,
      TRepeatingMonthly.repeatingTemplateId: repeatingTemplateId,
      TRepeatingMonthly.dayOfMonth: dayOfMonth,
    };
  }
}
