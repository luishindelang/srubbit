import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_repeating_templates.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsTask {
  final String id;
  final String name;
  final String emoji;
  final bool onEveryDate;
  final List<DsTaskDate> taskDates;
  final int? offset;
  final bool isImportant;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeUntil;
  final DsRepeatingTemplates? repeatingTemplate;
  final List<DsAccount>? taskOwners;

  final bool fromDB;

  DsTask({
    String? id,
    required this.name,
    required this.emoji,
    required this.onEveryDate,
    required this.taskDates,
    this.offset,
    required this.isImportant,
    this.timeFrom,
    this.timeUntil,
    this.repeatingTemplate,
    this.taskOwners,
    this.fromDB = false,
  }) : id = id ?? uuid();

  DsTask copyWith({
    String? newName,
    String? newEmoji,
    bool? newOnEveryDate,
    List<DsTaskDate>? newTaskDates,
    int? newOffset,
    bool? newIsImportant,
    TimeOfDay? newTimeFrom,
    TimeOfDay? newTimeUntil,
    DsRepeatingTemplates? newRepeatingTemplate,
    List<DsAccount>? newTaskOwners,
  }) {
    return DsTask(
      id: id,
      name: newName ?? name,
      emoji: newEmoji ?? emoji,
      onEveryDate: newOnEveryDate ?? onEveryDate,
      taskDates: newTaskDates ?? taskDates,
      offset: newOffset ?? offset,
      isImportant: newIsImportant ?? isImportant,
      timeFrom: newTimeFrom ?? timeFrom,
      timeUntil: newTimeUntil ?? timeUntil,
      repeatingTemplate: newRepeatingTemplate ?? repeatingTemplate,
      taskOwners: newTaskOwners ?? taskOwners,
    );
  }

  DsTask? nextRepeatingTask() {
    if (repeatingTemplate == null) return null;
    if (repeatingTemplate!.repeatingCount == 0) return null;

    List<DsTaskDate> newTaskDates = [];
    for (var date in taskDates) {
      DateTime newPlannedDate;

      if (repeatingTemplate!.repeatingType == TRepeatingTemplates.daily) {
        newPlannedDate = DateTime(
          date.plannedDate.year,
          date.plannedDate.month,
          date.plannedDate.day + repeatingTemplate!.repeatingIntervall,
        );
      } else if (repeatingTemplate!.repeatingType ==
          TRepeatingTemplates.weekly) {
        newPlannedDate = DateTime(
          date.plannedDate.year,
          date.plannedDate.month,
          date.plannedDate.day + (7 * repeatingTemplate!.repeatingIntervall),
        );
      } else if (repeatingTemplate!.repeatingType ==
          TRepeatingTemplates.monthly) {
        newPlannedDate = DateTime(
          date.plannedDate.year,
          date.plannedDate.month + repeatingTemplate!.repeatingIntervall,
          date.plannedDate.day,
        );
      } else {
        newPlannedDate = DateTime(
          date.plannedDate.year + repeatingTemplate!.repeatingIntervall,
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
      emoji: emoji,
      onEveryDate: onEveryDate,
      taskDates: newTaskDates,
      offset: offset,
      isImportant: isImportant,
      timeFrom: timeFrom,
      timeUntil: timeUntil,
      taskOwners: taskOwners,
    );
  }
}
