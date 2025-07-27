import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/DataStrukture/ds_repeating_templates.dart';

class DsTask {
  final String id;
  final String name;
  final DateTime plannedDate;
  final int completionWindow;
  final DateTime? offsetDate;
  final DateTime? timeFrom;
  final DateTime? timeUntil;
  final DsRepeatingTemplates? repeatingTemplate;
  final DateTime? doneDate;
  final List<DsAccount>? doneBy;

  final bool fromDB;

  const DsTask({
    required this.id,
    required this.name,
    required this.plannedDate,
    this.completionWindow = 0,
    this.offsetDate,
    this.timeFrom,
    this.timeUntil,
    this.repeatingTemplate,
    this.doneDate,
    this.doneBy,
    this.fromDB = false,
  });

  DsTask copyWith({
    String? newName,
    DateTime? newPlannedDate,
    int? newCompletionWindow,
    DateTime? newOffsetDate,
    DateTime? newTimeFrom,
    DateTime? newTimeUntil,
    String? newRepeatingTemplate,
  }) {
    return DsTask(
      id: id,
      name: newName ?? name,
      plannedDate: newPlannedDate ?? plannedDate,
      completionWindow: newCompletionWindow ?? completionWindow,
      offsetDate: newOffsetDate ?? offsetDate,
      timeFrom: newTimeFrom ?? timeFrom,
      timeUntil: newTimeFrom ?? timeUntil,
    );
  }
}
