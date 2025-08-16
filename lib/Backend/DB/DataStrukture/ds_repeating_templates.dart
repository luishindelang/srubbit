import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsRepeatingTemplates {
  final String id;
  final int repeatingType;
  final int repeatingIntervall;
  final int? repeatingCount;
  final bool repeatAfterDone;
  final DateTime startDate;
  final DateTime? endDate;

  DsRepeatingTemplates({
    String? id,
    required this.repeatingType,
    required this.repeatingIntervall,
    this.repeatingCount,
    required this.repeatAfterDone,
    required this.startDate,
    this.endDate,
  }) : id = id ?? uuid();

  DsRepeatingTemplates copyWith({
    int? newRepeatingType,
    int? newRepeatingIntervall,
    int? newRepeatingCount,
    bool? newRepeatAfterDone,
    DateTime? newStartDate,
    DateTime? newEndDate,
  }) {
    return DsRepeatingTemplates(
      id: id,
      repeatingType: newRepeatingType ?? repeatingType,
      repeatingIntervall: newRepeatingIntervall ?? repeatingIntervall,
      repeatingCount: newRepeatingCount ?? repeatingCount,
      repeatAfterDone: newRepeatAfterDone ?? repeatAfterDone,
      startDate: newStartDate ?? startDate,
      endDate: newEndDate ?? endDate,
    );
  }
}
