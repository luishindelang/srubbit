import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';

class UiTodayTasks extends ChangeNotifier {
  final _todayTasks = <DsTaskDate>[];

  UnmodifiableListView<DsTaskDate> get todayTasks =>
      UnmodifiableListView(_todayTasks);

  void set(List<DsTaskDate> items) {
    _todayTasks
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void add(DsTaskDate taskDate) {
    _todayTasks.add(taskDate);
    notifyListeners();
  }

  void remove(DsTaskDate taskDate) {
    _todayTasks.remove(taskDate);
    notifyListeners();
  }

  void update(DsTaskDate taskDate) {
    remove(taskDate);
    add(taskDate);
    notifyListeners();
  }
}
