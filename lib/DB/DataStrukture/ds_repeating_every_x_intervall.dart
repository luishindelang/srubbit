import 'package:scrubbit/DB/SQLite/Tables/t_repeating_exery_x_intervall.dart';

class DsRepeatingEveryXInterall {
  final String repeatingTemplateId;
  final String intervalType;
  final int intervalAmount;

  const DsRepeatingEveryXInterall({
    required this.repeatingTemplateId,
    required this.intervalType,
    required this.intervalAmount,
  });

  factory DsRepeatingEveryXInterall.fromMap(Map<String, dynamic> map) {
    return DsRepeatingEveryXInterall(
      repeatingTemplateId:
          map[TRepeatingEveryXIntervall.repeatingTemplateId] as String,
      intervalType: map[TRepeatingEveryXIntervall.intervallType] as String,
      intervalAmount: map[TRepeatingEveryXIntervall.intervallAmount] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TRepeatingEveryXIntervall.repeatingTemplateId: repeatingTemplateId,
      TRepeatingEveryXIntervall.intervallType: intervalType,
      TRepeatingEveryXIntervall.intervallAmount: intervalAmount,
    };
  }
}
