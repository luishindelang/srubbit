import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class SCreateTask {
  String? emoji;
  String? name;
  bool isImportant = false;
  bool isRepeating = false;

  List<DsAccount> selecedAccounts = [];

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

  bool get canBeDone => emoji != null && name != null;

  void onSelectAccount(List<DsAccount> newSelectedAccounts) {
    selecedAccounts = newSelectedAccounts;
  }

  void onChangeEmoji(String newEmoji) {
    emoji = newEmoji;
  }

  void onChangeName(String newName) {
    name = newName;
  }

  void onIsRepeating(bool newIsRepeating) {
    isRepeating = newIsRepeating;
  }

  void onTimesSelect(TimeOfDay? newTimeFrom, TimeOfDay? newTimeUntil) {
    timeFrom = newTimeFrom;
    timeUntil = newTimeUntil;
  }

  void onChangeType(int newType) {
    type = newType;
  }

  void onChangeOrAnd(bool newIsOr) {
    isOr = newIsOr;
  }

  void onSelectedDates(List<DateTime> newDates) {
    selectedDates = newDates;
  }

  void onRepeatingType(int newRepeatingType) {
    repeatingType = newRepeatingType;
  }

  void onRepeatingIntervall(int newRepeatingIntervall) {
    repeatingIntervall = newRepeatingIntervall;
  }

  void onRepeatingCount(int? newRepeatingCount) {
    repeatingCount = newRepeatingCount;
  }

  void onAfterComplete(bool newAfterComplete) {
    afterComplete = newAfterComplete;
  }

  void onStartDate(DateTime newStartDate) {
    startDate = newStartDate;
  }

  void onEndDate(DateTime? newEndDate) {
    endDate = newEndDate;
  }

  Future<void> onDone(BuildContext context) async {
    if (canBeDone) {
      DsTask newTask = DsTask(
        name: name!,
        emoji: emoji!,
        onEveryDate: !isOr,
        taskDates: [],
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

      Navigator.pop(context);
    }
  }
}
