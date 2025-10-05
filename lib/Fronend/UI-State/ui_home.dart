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
  final _doneTasks = <DsTaskDate>[];
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

  UnmodifiableListView<DsTaskDate> doneTask(List<DsAccount> accounts) {
    if (accounts.isEmpty) return UnmodifiableListView(_doneTasks);

    final selectedIds = accounts.map((a) => a.id).toList();
    final seenTaskIds = <String>{};
    final result = <DsTaskDate>[];

    for (final taskDate in _doneTasks) {
      final taskId = taskDate.task.id;
      if (seenTaskIds.contains(taskId)) continue;

      final matches =
          (taskDate.doneBy?.any((db) => selectedIds.contains(db.id))) ?? false;
      if (matches) {
        result.add(taskDate);
        seenTaskIds.add(taskId);
      }
    }
    result.sort((a, b) => b.plannedDate.compareTo(a.plannedDate));
    return UnmodifiableListView(result);
  }

  void _putTaskInRightList(DsTask task) {
    if (task.repeatingTemplate != null) {
      _repeatingTasks.insert(0, task);
    }
    if (task.onEveryDate) {
      for (var taskDate in task.taskDates) {
        final date = taskDate.plannedDate;
        if (taskDate.doneDate != null) {
          _doneTasks.insert(0, taskDate);
          continue;
        }
        if (date.isBefore(getNowWithoutTime())) {
          _missedTasks.insert(0, taskDate);
        } else if (isToday(date)) {
          _todayTasks.insert(0, taskDate);
        } else if (isInCurrentWeek(date)) {
          _weekTasks.insert(0, taskDate);
        } else if (isInCurrentMonth(date)) {
          _monthTasks.insert(0, taskDate);
        }
      }
    } else {
      for (var taskDate in task.taskDates) {
        final date = taskDate.plannedDate;
        if (taskDate.doneDate != null) {
          _doneTasks.insert(0, taskDate);
          continue;
        }
        if (date.isBefore(getNowWithoutTime())) {
          _missedTasks.insert(0, taskDate);
          continue;
        } else if (isToday(date)) {
          _todayTasks.insert(0, taskDate);
          return;
        } else if (isInCurrentWeek(date)) {
          _weekTasks.insert(0, taskDate);
          return;
        } else if (isInCurrentMonth(date)) {
          _monthTasks.insert(0, taskDate);
          return;
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

  void removeDone(DsTaskDate taskDate) async {
    _doneTasks.removeWhere((taskDateList) => taskDateList.id == taskDate.id);
    taskDate.task.taskDates.remove(taskDate);
    final dbService = await DatabaseService.init();
    await dbService.daoTaskDates.delete(taskDate.id);
    if (taskDate.task.taskDates.isEmpty) {
      _removeFromList(taskDate.task.id);
      await dbService.daoTasks.delete(taskDate.task.id);
    }
    if (taskDate.doneBy != null ? taskDate.doneBy!.isNotEmpty : false) {
      for (var account in taskDate.doneBy!) {
        account.update(newScore: account.score - 1);
        await dbService.daoAccounts.update(account);
      }
    }
    notifyListeners();
  }

  void loadData() async {
    if (!_isLoaded) {
      final dbService = await DatabaseService.init();
      // await dbService.resetDB();
      final data = await dbService.daoTasks.getAll();
      for (var task in data) {
        _putTaskInRightList(task);
      }
      _isLoaded = true;
      notifyListeners();
    }
  }

  void reloadData() {
    _isLoaded = false;
    _todayTasks.clear();
    _weekTasks.clear();
    _monthTasks.clear();
    _missedTasks.clear();
    _doneTasks.clear();
    _repeatingTasks.clear();
    loadData();
  }

  void addTask(DsTask task) async {
    final dbService = await DatabaseService.init();
    await dbService.daoTasks.insert(task);
    task.createRepeatingDates();
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

  void onTaskDateDone(DsTaskDate taskDate, List<DsAccount> accounts) async {
    final now = DateTime.now();
    final dbService = await DatabaseService.init();

    if (taskDate.task.onEveryDate) {
      taskDate.update(newDoneDate: now, newDoneBy: accounts);
      if (taskDate.task.repeatingTemplate != null) {
        await dbService.daoTaskDates.insert(taskDate, taskDate.task.id);
        taskDate.task.repeatingTemplate!.update(newLastDoneDate: now);
      } else {
        await dbService.daoTaskDates.update(taskDate);
      }
    } else {
      for (var oneTaskDate in taskDate.task.taskDates) {
        oneTaskDate.update(newDoneDate: now, newDoneBy: accounts);
        if (taskDate.task.repeatingTemplate != null) {
          await dbService.daoTaskDates.insert(taskDate, taskDate.task.id);
          taskDate.task.repeatingTemplate!.update(newLastDoneDate: now);
        } else {
          await dbService.daoTaskDates.update(taskDate);
        }
      }
    }
    taskDate.task.createRepeatingDates();
    _removeFromList(taskDate.task.id);
    _putTaskInRightList(taskDate.task);
    notifyListeners();
  }

  void onTaskMoveToNextDay(DsTaskDate taskDate) async {
    taskDate.update(
      newPlannedDate: taskDate.plannedDate.add(Duration(days: 1)),
    );
    final dbService = await DatabaseService.init();
    await dbService.daoTaskDates.update(taskDate);
    _removeFromList(taskDate.task.id);
    _putTaskInRightList(taskDate.task);
    notifyListeners();
  }
}
