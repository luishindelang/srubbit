import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_lists.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class UiCreateTask extends ChangeNotifier {
  DsTask _newTask = DsTask(
    name: "",
    emoji: "",
    onEveryDate: false,
    isImportant: false,
  );
  bool isEdit = false;
  bool isTimeSpan = false;

  UiCreateTask({DsTask? task}) {
    if (task != null) {
      _newTask = task;
      isEdit = true;
    }
  }

  int setType = 0;

  bool completeWeek = true;
  bool completeMonth = true;

  String get name => _newTask.name;
  String get emoji => _newTask.emoji;
  bool get isImportant => _newTask.isImportant;
  bool get isRepeating => _newTask.repeatingTemplate != null;

  List<DsAccount> get selecedAccounts => _newTask.taskOwners ?? [];

  TimeOfDay? get timeFrom => _newTask.timeFrom;
  TimeOfDay? get timeUntil => _newTask.timeUntil;

  List<DateTime> get selectedDates =>
      _newTask.taskDates.map((taskDate) {
        return taskDate.plannedDate;
      }).toList();

  bool get selectAll =>
      _newTask.taskOwners != null ? _newTask.taskOwners!.isEmpty : true;

  int get type {
    if (_newTask.taskDates.isNotEmpty) {
      var first = _newTask.taskDates.first.plannedDate;
      if (isToday(first)) return 0;
      if (isTomorrow(first)) return 1;
      if (isInCurrentWeek(first)) return 2;
      if (isInCurrentMonth(first)) return 3;
      return 4;
    }
    return 0;
  }

  bool get isOr => !_newTask.onEveryDate;

  DsRepeatingTemplates get _repeatingTemplate =>
      _newTask.repeatingTemplate ??
      DsRepeatingTemplates(
        repeatingType: 0,
        repeatingIntervall: 1,
        repeatAfterDone: false,
        startDate: getNowWithoutTime(),
      );

  int get repeatingType => _repeatingTemplate.repeatingType;
  int get repeatingIntervall => _repeatingTemplate.repeatingIntervall;
  int? get repeatingCount => _repeatingTemplate.repeatingCount;
  bool get repeatAfterDone => _repeatingTemplate.repeatAfterDone;
  DateTime get startDateRepeating => _repeatingTemplate.startDate;
  DateTime? get endDateRepeating => _repeatingTemplate.endDate;

  bool get canDoDone => _newTask.name.isNotEmpty && _newTask.emoji.isNotEmpty;

  void onSetType(int newType) {
    setType = newType;
  }

  void onSelectAccount(List<DsAccount> newSelectedAccounts) {
    _newTask.update(newTaskOwners: newSelectedAccounts);
    notifyListeners();
  }

  void onSelectAllAccounts() {
    _newTask.update(newTaskOwners: []);
    notifyListeners();
  }

  void onTimesSelect(TimeOfDay? newTimeFrom, TimeOfDay? newTimeUntil) {
    _newTask.update(newTimeFrom: newTimeFrom, newTimeUntil: newTimeUntil);
    notifyListeners();
  }

  void onChangeName(String newName) {
    _newTask.update(newName: newName);
    notifyListeners();
  }

  void onChangeEmoji(String emoji) {
    _newTask.update(newEmoji: emoji);
    notifyListeners();
  }

  void onChangeImportant(bool isImportant) {
    _newTask.update(newIsImportant: isImportant);
  }

  void onChangeTimeSpan(bool newIsTimeSpan) {
    isTimeSpan = newIsTimeSpan;
  }

  void onSelectCompleteWeek() {
    completeWeek = !completeWeek;
    notifyListeners();
  }

  void onSelectCompleteMonth() {
    completeMonth = !completeMonth;
    notifyListeners();
  }

  void onSelectWeekDay(DateTime day, List<DateTime> weekDays) {
    if (isTimeSpan) {
      if (_newTask.taskDates.isEmpty) {
        _newTask.addTaskDate(DsTaskDate(plannedDate: day, task: _newTask));
        notifyListeners();
      } else if (_newTask.taskDates.length == 1) {
        int to = weekDays.indexOf(day);
        int from = weekDays.indexOf(selectedDates.last);
        _newTask.clearTaskDate();
        onSelectedDates(timeSpann(weekDays, from, to));
      } else {
        _newTask.clearTaskDate();
        _newTask.addTaskDate(DsTaskDate(plannedDate: day, task: _newTask));
        notifyListeners();
      }
    } else {
      for (var taskDate in _newTask.taskDates) {
        if (isSameDay(taskDate.plannedDate, day)) {
          _newTask.removeTaskDate(taskDate);
          notifyListeners();
          return;
        }
      }
      _newTask.addTaskDate(DsTaskDate(plannedDate: day, task: _newTask));
      notifyListeners();
    }
  }

  void onSelectedDates(List<DateTime> newDates) {
    newDates.sort((a, b) => a.compareTo(b));
    _newTask.clearTaskDate();
    for (var date in newDates) {
      _newTask.addTaskDate(DsTaskDate(plannedDate: date, task: _newTask));
    }
    notifyListeners();
  }

  void onIsRepeating(bool isRepeating) {
    if (isRepeating) {
      _newTask.update(newRepeatingTemplate: _repeatingTemplate);
    } else {
      _newTask.update(newRepeatingTemplate: null);
    }
    notifyListeners();
  }

  void onChangeIsOr(bool isOr) {
    _newTask.update(newOnEveryDate: !isOr);
    notifyListeners();
  }

  void onRepeatingIntervall(int repeatingIntervall) {
    _repeatingTemplate.update(newRepeatingIntervall: repeatingIntervall);
  }

  void onRepeatingType(int repeatingType) {
    _repeatingTemplate.update(newRepeatingType: repeatingType);
    notifyListeners();
  }

  void onAfterComplete(bool repeatAfterDone) {
    _repeatingTemplate.update(newRepeatAfterDone: repeatAfterDone);
    notifyListeners();
  }

  void onStartDateRepeating(DateTime? startDateRepeating) {
    _repeatingTemplate.update(
      newStartDate: startDateRepeating ?? getNowWithoutTime(),
    );
    notifyListeners();
  }

  void onEndDateRepeating(DateTime? endDateRepeating) {
    _repeatingTemplate.update(newEndDate: endDateRepeating);
    notifyListeners();
  }

  void onRepeatingCount(int? repeatingCount) {
    _repeatingTemplate.update(newRepeatingCount: repeatingCount);
  }

  DsTask? onDone() {
    if (canDoDone) {
      if (setType == 2 && !isRepeating) onSelectedDates(datesUntilEndOfMonth());
      if (setType == 3 && !isRepeating) onSelectedDates(datesUntilEndOfMonth());
      return _newTask;
    }
    return null;
  }
}
