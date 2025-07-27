import 'package:scrubbit/DB/SQLite/Tables/t_repeating_yearly.dart';

class DsRepeatingYearly {
  final String repeatingTemplateId;
  final int month;
  final int day;

  const DsRepeatingYearly({
    required this.repeatingTemplateId,
    required this.month,
    required this.day,
  });

  factory DsRepeatingYearly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingYearly(
      repeatingTemplateId: map[TRepeatingYearly.repeatingTemplateId] as String,
      month: map[TRepeatingYearly.month] as int,
      day: map[TRepeatingYearly.day] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingYearly.repeatingTemplateId: repeatingTemplateId,
      TRepeatingYearly.month: month,
      TRepeatingYearly.day: day,
    };
  }
}
