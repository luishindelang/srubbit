import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';

class UiHomeState extends ChangeNotifier {
  final _todayTasks = <DsTaskDate>[];
  final _weekTasks = <DsTaskDate>[];
  final _monthTasks = <DsTaskDate>[];
  final _missedTasks = <DsTaskDate>[];
  final _accounts = <DsAccount>[];
  final _repeatingTasks = <DsTask>[];

  UnmodifiableListView<DsTaskDate> get todayTasks =>
      UnmodifiableListView(_todayTasks);
  UnmodifiableListView<DsTaskDate> get weekTasks =>
      UnmodifiableListView(_weekTasks);
  UnmodifiableListView<DsTaskDate> get monthTasks =>
      UnmodifiableListView(_monthTasks);
  UnmodifiableListView<DsTaskDate> get missedTasks =>
      UnmodifiableListView(_missedTasks);
  UnmodifiableListView<DsAccount> get accounts =>
      UnmodifiableListView(_accounts);
  UnmodifiableListView<DsTask> get repeatingTasks =>
      UnmodifiableListView(_repeatingTasks);

  void setTodayTasks(List<DsTaskDate> items) {
    _todayTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setWeekTasks(List<DsTaskDate> items) {
    _weekTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setMonthTasks(List<DsTaskDate> items) {
    _monthTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setMissedTasks(List<DsTaskDate> items) {
    _missedTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setAccounts(List<DsAccount> items) {
    _accounts
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setRepeatingTasks(List<DsTask> items) {
    _repeatingTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void addTodayTask(DsTaskDate taskDate) {
    _todayTasks.add(taskDate);
    notifyListeners();
  }

  void removeTodayTaskById(DsTaskDate taskDate) {
    _todayTasks.remove(taskDate);
    notifyListeners();
  }

  void addWeekTask(DsTaskDate taskDate) {
    _weekTasks.add(taskDate);
    notifyListeners();
  }

  void removeWeekTaskById(DsTaskDate taskDate) {
    _todayTasks.remove(taskDate);
    notifyListeners();
  }

  void addMonthTask(DsTaskDate taskDate) {
    _monthTasks.add(taskDate);
    notifyListeners();
  }

  void removeMonthTaskById(DsTaskDate taskDate) {
    _todayTasks.remove(taskDate);
    notifyListeners();
  }

  void addMissedTask(DsTaskDate taskDate) {
    _missedTasks.add(taskDate);
    notifyListeners();
  }

  void removeMissedTaskById(DsTaskDate taskDate) {
    _todayTasks.remove(taskDate);
    notifyListeners();
  }

  void addAccount(DsAccount account) {
    _accounts.add(account);
    notifyListeners();
  }

  void upsertAccount(DsAccount a) {
    final i = _accounts.indexWhere((x) => x.id == a.id);
    if (i == -1) {
      _accounts.add(a);
    } else {
      _accounts[i] = a;
    }
    notifyListeners();
  }

  void upsertRepeatingTask(DsTask t) {
    final i = _repeatingTasks.indexWhere((x) => x.id == t.id);
    if (i == -1) {
      _repeatingTasks.add(t);
    } else {
      _repeatingTasks[i] = t;
    }
    notifyListeners();
  }
}
