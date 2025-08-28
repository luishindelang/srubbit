import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsTaskDate {
  final String id;
  final DateTime plannedDate;
  final int completionWindow;
  final DateTime? doneDate;
  final List<DsAccount>? doneBy;

  final bool fromDB;

  DsTaskDate({
    String? id,
    required this.plannedDate,
    this.completionWindow = 0,
    this.doneDate,
    this.doneBy,
    this.fromDB = false,
  }) : id = id ?? uuid();

  DsTaskDate copyWith({
    DateTime? newPlannedDate,
    int? newCompletionWindow,
    DateTime? newDoneDate,
    List<DsAccount>? newDoneBy,
  }) {
    return DsTaskDate(
      id: id,
      plannedDate: newPlannedDate ?? plannedDate,
      completionWindow: newCompletionWindow ?? completionWindow,
      doneDate: newDoneDate ?? doneDate,
      doneBy: newDoneBy ?? doneBy,
    );
  }
}
