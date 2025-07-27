import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_repeating_templates.dart';

class DsTask {
  final String id;
  final String name;
  final bool onEveryDate;
  final List<DsTaskDate> taskDates;
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
    required this.onEveryDate,
    required this.taskDates,
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
    bool? newOnEveryDate,
    List<DsTaskDate>? newTaskDates,
    DateTime? newOffsetDate,
    DateTime? newTimeFrom,
    DateTime? newTimeUntil,
    String? newRepeatingTemplate,
    DateTime? newDoneDate,
    List<DsAccount>? newDoneBy,
  }) {
    return DsTask(
      id: id,
      name: newName ?? name,
      onEveryDate: newOnEveryDate ?? onEveryDate,
      taskDates: newTaskDates ?? taskDates,
      offsetDate: newOffsetDate ?? offsetDate,
      timeFrom: newTimeFrom ?? timeFrom,
      timeUntil: newTimeFrom ?? timeUntil,
      doneDate: newDoneDate ?? doneDate,
      doneBy: newDoneBy ?? doneBy,
    );
  }

  DsTask? nextRepeatingTask() {
    if (repeatingTemplate != null) {
      List<DsTaskDate> newTaskDates = [];
      for (var date in taskDates) {
        DateTime newPlannedDate;

        if (repeatingTemplate!.repeatingType == TRepeatingTemplates.daily) {
          newPlannedDate = DateTime(
            date.plannedDate.year,
            date.plannedDate.month,
            date.plannedDate.day + repeatingTemplate!.repeatingAmount,
          );
        } else if (repeatingTemplate!.repeatingType ==
            TRepeatingTemplates.weekly) {
          newPlannedDate = DateTime(
            date.plannedDate.year,
            date.plannedDate.month,
            date.plannedDate.day + (7 * repeatingTemplate!.repeatingAmount),
          );
        } else if (repeatingTemplate!.repeatingType ==
            TRepeatingTemplates.monthly) {
          newPlannedDate = DateTime(
            date.plannedDate.year,
            date.plannedDate.month + repeatingTemplate!.repeatingAmount,
            date.plannedDate.day,
          );
        } else {
          newPlannedDate = DateTime(
            date.plannedDate.year + repeatingTemplate!.repeatingAmount,
            date.plannedDate.month,
            date.plannedDate.day,
          );
        }

        DsTaskDate newDate = date.copyWith(newPlannedDate: newPlannedDate);
        newTaskDates.add(newDate);
      }
      return DsTask(
        id: id,
        name: name,
        onEveryDate: onEveryDate,
        taskDates: newTaskDates,
        offsetDate: offsetDate,
        timeFrom: timeFrom,
        timeUntil: timeUntil,
      );
    }
    return null;
  }
}
