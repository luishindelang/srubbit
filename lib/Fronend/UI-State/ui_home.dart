import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';

class UiHome extends ChangeNotifier {
  final _todayTasks = <DsTaskDate>[];
  final _weekTasks = <DsTaskDate>[];
  final _monthTasks = <DsTaskDate>[];
  final _missedTasks = <DsTaskDate>[];
  final _repeatingTasks = <DsTask>[];

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

  void loadData() {
    notifyListeners();
  }

  void addTaskDate(DsTask task) {
    notifyListeners();
  }

  void onTaskDateDone(DsTaskDate taskDate) {
    notifyListeners();
  }

  void onTasMoveToNextDay(DsTask task) {
    notifyListeners();
  }
}
