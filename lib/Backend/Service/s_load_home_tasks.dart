import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class SLoadHomeTasks {
  List<DsTask> _todayTasks = [];
  List<DsTask> _weekTasks = [];
  List<DsTask> _monthTasks = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<DsTask> get todayTasks => _todayTasks;
  List<DsTask> get weekTasks => _weekTasks;
  List<DsTask> get monthTasks => _monthTasks;

  void addNewTask(DsTask newTask) {
    if (newTask.taskDates.isNotEmpty) {
      bool today = false;
      bool week = false;
      bool month = false;

      for (var date in newTask.taskDates) {
        if (date.completionWindow == 0 && date.doneDate == null) {
          today = isToday(date.plannedDate);
          if (today) {
            _todayTasks.add(newTask);
            return;
          }
        }
      }
      if (!today) {
        for (var date in newTask.taskDates) {
          if (date.doneDate == null) {
            week = isInCurrentWeek(date.plannedDate);
            if (week) {
              _weekTasks.add(newTask);
              return;
            }
          }
        }
      }
      if (!week) {
        for (var date in newTask.taskDates) {
          if (date.doneDate == null) {
            month = isInCurrentWeek(date.plannedDate);
            if (month) {
              _monthTasks.add(newTask);
              return;
            }
          }
        }
      }
    }
  }

  void updateTask(DsTask oldTask, DsTask newTask) {
    _todayTasks.remove(oldTask);
    _weekTasks.remove(oldTask);
    _monthTasks.remove(oldTask);
    addNewTask(newTask);
  }

  void removeTask(DsTask task) {}

  Future<void> loadData() async {
    _isLoaded = true;
    _todayTasks = [
      DsTask(
        name: "Putzen ist ein ganz langer name der nicht drauf passt",
        emoji: "😄",
        onEveryDate: true,
        taskDates: [],
        isImportant: true,
        timeFrom: TimeOfDay(hour: 13, minute: 10),
        timeUntil: TimeOfDay(hour: 14, minute: 50),
      ),
      DsTask(
        name: "Putzen ist ein ganz langer name der nicht drauf passt",
        emoji: "😄",
        onEveryDate: true,
        taskDates: [],
        isImportant: false,
        timeFrom: TimeOfDay(hour: 13, minute: 10),
      ),
    ];
  }
}
