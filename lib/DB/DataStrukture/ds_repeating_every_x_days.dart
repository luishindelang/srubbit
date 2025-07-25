import 'package:scrubbit/DB/SQLite/Tables/RepeatingTypes/t_repeating_exery_x_days.dart';

class DsRepeatingEveryXDays {
  final String id;
  final String templateId;
  final int intervalDays;

  const DsRepeatingEveryXDays({
    required this.id,
    required this.templateId,
    required this.intervalDays,
  });

  factory DsRepeatingEveryXDays.fromMap(Map<String, dynamic> map) {
    return DsRepeatingEveryXDays(
      id: map[TRepeatingEveryXDays.id] as String,
      templateId: map[TRepeatingEveryXDays.templateId] as String,
      intervalDays: map[TRepeatingEveryXDays.intervalDays] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingEveryXDays.id: id,
      TRepeatingEveryXDays.templateId: templateId,
      TRepeatingEveryXDays.intervalDays: intervalDays,
    };
  }
}
