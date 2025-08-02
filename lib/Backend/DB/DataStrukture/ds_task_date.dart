import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsTaskDate {
  final String id;
  final DateTime plannedDate;
  final int completionWindow;

  final bool fromDB;

  DsTaskDate({
    String? id,
    required this.plannedDate,
    required this.completionWindow,
    this.fromDB = false,
  }) : id = id ?? uuid();

  DsTaskDate copyWith({DateTime? newPlannedDate, int? newCompletionWindow}) {
    return DsTaskDate(
      id: id,
      plannedDate: newPlannedDate ?? plannedDate,
      completionWindow: newCompletionWindow ?? completionWindow,
    );
  }
}
