import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class SCreateTask {
  String? emoji;
  String? name;
  bool isImportant = false;
  bool isRepeating = false;

  List<DsAccount>? selecedAccounts;

  TimeOfDay? timeFrom;
  TimeOfDay? timeUntil;

  int type = 0;
  bool isOr = false;
  List<DateTime> selectedDates = [];

  int repeatingType = 0;
  int repeatingIntervall = 1;
  int? repeatingCount;
  bool afterComplete = false;
  DateTime startDate = getNowWithoutTime();
  DateTime? endDate;

  bool get canBeDone =>
      emoji != null && name != null && selecedAccounts != null;

  bool isChanged = false;

  void onSelectAccount(List<DsAccount> newSelectedAccounts) {
    selecedAccounts = newSelectedAccounts;
    isChanged = true;
  }

  void onChangeEmoji(String newEmoji) {
    emoji = newEmoji;
    isChanged = true;
  }

  void onChangeImportant(bool newIsImportant) {
    isImportant = newIsImportant;
    isChanged = true;
  }

  void onChangeName(String newName) {
    name = newName;
    isChanged = true;
  }

  void onIsRepeating(bool newIsRepeating) {
    isRepeating = newIsRepeating;
    isChanged = true;
  }

  void onTimesSelect(TimeOfDay? newTimeFrom, TimeOfDay? newTimeUntil) {
    timeFrom = newTimeFrom;
    timeUntil = newTimeUntil;
    isChanged = true;
  }

  void onChangeType(int newType) {
    type = newType;
    isChanged = true;
  }

  void onChangeOrAnd(bool newIsOr) {
    isOr = newIsOr;
    isChanged = true;
  }

  void onSelectedDates(List<DateTime> newDates) {
    selectedDates = newDates;
    isChanged = true;
  }

  void onRepeatingType(int newRepeatingType) {
    repeatingType = newRepeatingType;
    isChanged = true;
  }

  void onRepeatingIntervall(int newRepeatingIntervall) {
    repeatingIntervall = newRepeatingIntervall;
    isChanged = true;
  }

  void onRepeatingCount(int? newRepeatingCount) {
    repeatingCount = newRepeatingCount;
    isChanged = true;
  }

  void onAfterComplete(bool newAfterComplete) {
    afterComplete = newAfterComplete;
    isChanged = true;
  }

  void onStartDate(DateTime newStartDate) {
    startDate = newStartDate;
    isChanged = true;
  }

  void onEndDate(DateTime? newEndDate) {
    endDate = newEndDate;
    isChanged = true;
  }

  Future<void> onDone(BuildContext context) async {
    if (canBeDone && isChanged) {
      var now = getNowWithoutTime();
      List<DsTaskDate> taskDates = [];
      if (type == 0) {
        taskDates.add(DsTaskDate(plannedDate: now));
      } else if (type == 1) {
        taskDates.add(DsTaskDate(plannedDate: getNowWithoutTime(addDay: 1)));
      } else if (type == 2 && selectedDates.isEmpty) {
        taskDates.add(
          DsTaskDate(
            plannedDate: now,
            completionWindow: daysUntilEndOfWeek(now),
          ),
        );
      } else if (type == 3 && selectedDates.isEmpty) {
        taskDates.add(
          DsTaskDate(
            plannedDate: now,
            completionWindow: daysUntilEndOfMonth(now),
          ),
        );
      } else {
        for (var date in selectedDates) {
          taskDates.add(DsTaskDate(plannedDate: date));
        }
      }

      DsTask newTask = DsTask(
        name: name!,
        emoji: emoji!,
        onEveryDate: !isOr,
        taskDates: taskDates,
        type: type,
        isImportant: isImportant,
        timeFrom: timeFrom,
        timeUntil: timeUntil,
        taskOwners: selecedAccounts,
        repeatingTemplate:
            isRepeating
                ? DsRepeatingTemplates(
                  repeatingType: repeatingType,
                  repeatingIntervall: repeatingIntervall,
                  repeatAfterDone: afterComplete,
                  repeatingCount: repeatingCount,
                  startDate: startDate,
                  endDate: endDate,
                )
                : null,
      );
      // save in db
      Navigator.pop(context, newTask);
    } else if (canBeDone && !isChanged) {
      Navigator.pop(context);
    }
  }

  void loadDataFromTask(DsTask task) {
    name = task.name;
    emoji = task.emoji;
    isOr = !task.onEveryDate;
    isImportant = task.isImportant;
    timeFrom = task.timeFrom;
    timeUntil = task.timeUntil;
    selecedAccounts = task.taskOwners ?? [];
    isRepeating = task.repeatingTemplate != null;
    type = task.type;
    if (isRepeating) {
      repeatingType = task.repeatingTemplate!.repeatingType;
      repeatingIntervall = task.repeatingTemplate!.repeatingIntervall;
      afterComplete = task.repeatingTemplate!.repeatAfterDone;
      repeatingCount = task.repeatingTemplate!.repeatingCount;
      startDate = task.repeatingTemplate!.startDate;
      endDate = task.repeatingTemplate!.endDate;
    }
    for (var taskDate in task.taskDates) {
      selectedDates.add(taskDate.plannedDate);
    }
  }
}
