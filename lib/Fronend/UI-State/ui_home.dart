import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';

class UiHome extends ChangeNotifier {
  final _todayTasks = <DsTaskDate>[];
  final _weekTasks = <DsTaskDate>[];
  final _monthTasks = <DsTaskDate>[];
  final _missedTasks = <DsTaskDate>[];
  final _repeatingTasks = <DsTask>[];

  bool _isLoaded = false;

  UnmodifiableListView<DsTaskDate> get todayTasks =>
      UnmodifiableListView(_todayTasks);
  UnmodifiableListView<DsTaskDate> get weekTasks =>
      UnmodifiableListView(_weekTasks);
  UnmodifiableListView<DsTaskDate> get monthTasks =>
      UnmodifiableListView(_monthTasks);
  UnmodifiableListView<DsTaskDate> get missedTasks =>
      UnmodifiableListView(_missedTasks);
  UnmodifiableListView<DsTask> get repeatingTasks =>
      UnmodifiableListView(_repeatingTasks);

  void _putTaskInRightList(DsTask task) {
    if (task.repeatingTemplate != null) {
      _repeatingTasks.add(task);
    }
    if (task.onEveryDate) {
      for (var taskDate in task.taskDates) {
        final date = taskDate.plannedDate;
        if (taskDate.doneDate != null) break;
        if (date.isBefore(getNowWithoutTime())) {
          _missedTasks.add(taskDate);
        } else if (isToday(date)) {
          _todayTasks.add(taskDate);
        } else if (isInCurrentWeek(date)) {
          _weekTasks.add(taskDate);
        } else if (isInCurrentMonth(date)) {
          _monthTasks.add(taskDate);
        }
      }
    } else {
      final dates =
          task.taskDates.map((taskDate) => taskDate.plannedDate).toList();
      if (allDaysUntilEndOfMonthIncluded(dates)) {
        _monthTasks.add(task.taskDates.first);
        return;
      }
      if (allDaysUntilSundayIncluded(dates)) {
        _weekTasks.add(task.taskDates.first);
        return;
      }
      for (var taskDate in task.taskDates) {
        final date = taskDate.plannedDate;
        if (taskDate.doneDate != null) {
          break;
        }
        if (date.isBefore(getNowWithoutTime())) {
          _missedTasks.add(taskDate);
          break;
        } else if (isToday(date)) {
          _todayTasks.add(taskDate);
          break;
        } else if (isInCurrentWeek(date)) {
          _weekTasks.add(taskDate);
          break;
        } else if (isInCurrentMonth(date)) {
          _monthTasks.add(taskDate);
          break;
        }
      }
    }
  }

  void _removeFromList(String id) {
    _todayTasks.removeWhere((taskDate) => taskDate.task.id == id);
    _weekTasks.removeWhere((taskDate) => taskDate.task.id == id);
    _monthTasks.removeWhere((taskDate) => taskDate.task.id == id);
    _missedTasks.removeWhere((taskDate) => taskDate.task.id == id);
    _repeatingTasks.removeWhere((task) => task.id == id);
  }

  void remove(String id) async {
    _removeFromList(id);
    final dbService = await DatabaseService.init();
    await dbService.daoTasks.delete(id);
    notifyListeners();
  }

  void loadData() async {
    if (!_isLoaded) {
      final dbService = await DatabaseService.init();
      final data = await dbService.daoTasks.getAll();
      for (var task in data) {
        _putTaskInRightList(task);
      }
      _isLoaded = true;
      notifyListeners();
    }
  }

  void addTask(DsTask task) async {
    final dbService = await DatabaseService.init();
    await dbService.daoTasks.insert(task);
    _putTaskInRightList(task);
    notifyListeners();
  }

  void updateTask(DsTask task) async {
    final dbService = await DatabaseService.init();
    dbService.daoTasks.update(task);
    _removeFromList(task.id);
    _putTaskInRightList(task);
    notifyListeners();
  }

  void onTaskDateDone(DsTaskDate taskDate, List<DsAccount> accounts) {
    notifyListeners();
  }

  void onTaskMoveToNextDay(DsTaskDate taskDate) async {
    taskDate.update(
      newPlannedDate: taskDate.plannedDate.add(Duration(days: 1)),
    );
    final dbService = await DatabaseService.init();
    dbService.daoTaskDates.update(taskDate);
    _removeFromList(taskDate.task.id);
    _putTaskInRightList(taskDate.task);
    notifyListeners();
  }
}
