import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
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

  void onAfterComplete(bool newAfterComplete) {
    afterComplete = newAfterComplete;
  }

  void onStartDate(DateTime newStartDate) {
    startDate = newStartDate;
  }

  void onEndDate(DateTime? newEndDate) {
    endDate = newEndDate;
  }

  void onDone() {}
}
