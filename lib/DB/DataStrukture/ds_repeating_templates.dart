import 'package:scrubbit/DB/Service/s_uuid.dart';

class DsRepeatingTemplates {
  final String id;
  final String repeatingType;
  final int repeatingAmount;
  final DateTime startDateInt;
  final DateTime? endDateInt;

  DsRepeatingTemplates({
    String? id,
    required this.repeatingType,
    required this.repeatingAmount,
    required this.startDateInt,
    this.endDateInt,
  }) : id = id ?? uuid();

  DsRepeatingTemplates copyWith({
    String? newRepeatingType,
    int? newRepeatingAmount,
    DateTime? newStartDate,
    DateTime? newEndDate,
  }) {
    return DsRepeatingTemplates(
      id: id,
      repeatingType: newRepeatingType ?? repeatingType,
      repeatingAmount: newRepeatingAmount ?? repeatingAmount,
      startDateInt: newStartDate ?? startDateInt,
      endDateInt: newEndDate ?? endDateInt,
    );
  }
}
