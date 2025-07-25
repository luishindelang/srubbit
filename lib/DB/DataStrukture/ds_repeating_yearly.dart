import 'package:scrubbit/DB/SQLite/Tables/t_repeating_yearly.dart';

class DsRepeatingYearly {
  final String id;
  final String templateId;
  final int month;
  final int day;

  const DsRepeatingYearly({
    required this.id,
    required this.templateId,
    required this.month,
    required this.day,
  });

  factory DsRepeatingYearly.fromMap(Map<String, dynamic> map) {
    return DsRepeatingYearly(
      id: map[TRepeatingYearly.id] as String,
      templateId: map[TRepeatingYearly.templateId] as String,
      month: map[TRepeatingYearly.month] as int,
      day: map[TRepeatingYearly.day] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingYearly.id: id,
      TRepeatingYearly.templateId: templateId,
      TRepeatingYearly.month: month,
      TRepeatingYearly.day: day,
    };
  }
}
