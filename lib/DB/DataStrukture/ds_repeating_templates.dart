import 'package:scrubbit/DB/Service/s_uuid.dart';

class DsRepeatingTemplates {
  final String id;
  final String repeatingType;
  final int repeatingIntervall;
  final int? repeatingCount;
  final DateTime startDateInt;
  final DateTime? endDateInt;

  DsRepeatingTemplates({
    String? id,
    required this.repeatingType,
    required this.repeatingIntervall,
    this.repeatingCount,
    required this.startDateInt,
    this.endDateInt,
  }) : id = id ?? uuid();

  DsRepeatingTemplates copyWith({
    String? newRepeatingType,
    int? newRepeatingIntervall,
    int? newRepeatingCount,
    DateTime? newStartDate,
    DateTime? newEndDate,
  }) {
    return DsRepeatingTemplates(
      id: id,
      repeatingType: newRepeatingType ?? repeatingType,
      repeatingIntervall: newRepeatingIntervall ?? repeatingIntervall,
      repeatingCount: newRepeatingCount ?? repeatingCount,
      startDateInt: newStartDate ?? startDateInt,
      endDateInt: newEndDate ?? endDateInt,
    );
  }
}
