import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsTask {
  late String _id;
  late String _name;
  late String _emoji;
  late bool _onEveryDate;
  late int _offset;
  late bool _isImportant;
  late TimeOfDay? _timeFrom;
  late TimeOfDay? _timeUntil;
  late DsRepeatingTemplates? _repeatingTemplate;
  late List<DsAccount>? _taskOwners;

  late List<DsTaskDate> _taskDates;

  List<DsTaskDate> addTaskDates = [];
  List<DsTaskDate> removedTaskDates = [];

  late bool fromDB;

  DsTask({
    String? id,
    required String name,
    required String emoji,
    required bool onEveryDate,
    int offset = 0,
    required bool isImportant,
    TimeOfDay? timeFrom,
    TimeOfDay? timeUntil,
    DsRepeatingTemplates? repeatingTemplate,
    List<DsAccount>? taskOwners,
    List<DsTaskDate> taskDates = const [],
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _name = name;
    _emoji = emoji;
    _onEveryDate = onEveryDate;
    _offset = offset;
    _isImportant = isImportant;
    _timeFrom = timeFrom;
    _timeUntil = timeUntil;
    _repeatingTemplate = repeatingTemplate;
    _taskOwners = taskOwners;
    _taskDates = taskDates;
  }

  String get id => _id;
  String get name => _name;
  String get emoji => _emoji;
  bool get onEveryDate => _onEveryDate;
  int get offset => _offset;
  bool get isImportant => _isImportant;
  TimeOfDay? get timeFrom => _timeFrom;
  TimeOfDay? get timeUntil => _timeUntil;
  DsRepeatingTemplates? get repeatingTemplate => _repeatingTemplate;
  List<DsAccount>? get taskOwners => _taskOwners;
  List<DsTaskDate> get taskDates => _taskDates;

  set setTaskDates(List<DsTaskDate> newTaskDates) => _taskDates = newTaskDates;

  void _addTaskDate(DsTaskDate newTaskDate) {
    addTaskDates.add(newTaskDate);
  }

  void _removeTaskDate(DsTaskDate taskDate) {
    _taskDates.remove(taskDate);
    removedTaskDates.add(taskDate);
  }

  void _updateTaskDate(List<DsTaskDate> newTaskDates) {
    for (var newTaskDate in newTaskDates) {
      if (!_taskDates.contains(newTaskDate)) _addTaskDate(newTaskDate);
    }
    for (var oldTaskDate in _taskDates) {
      if (!newTaskDates.contains(oldTaskDate)) _removeTaskDate(oldTaskDate);
    }
  }

  void update({
    String? newName,
    String? newEmoji,
    bool? newOnEveryDate,
    int? newType,
    int? newOffset,
    bool? newIsImportant,
    TimeOfDay? newTimeFrom,
    TimeOfDay? newTimeUntil,
    DsRepeatingTemplates? newRepeatingTemplate,
    List<DsAccount>? newTaskOwners,
    List<DsTaskDate>? newTaskDates,
  }) {
    _name = newName ?? _name;
    _emoji = newEmoji ?? _emoji;
    _onEveryDate = newOnEveryDate ?? _onEveryDate;
    _offset = newOffset ?? _offset;
    _isImportant = newIsImportant ?? _isImportant;
    _timeFrom = newTimeFrom ?? _timeFrom;
    _timeUntil = newTimeUntil ?? _timeUntil;
    _repeatingTemplate = newRepeatingTemplate ?? _repeatingTemplate;
    _taskOwners = newTaskOwners ?? _taskOwners;
    _updateTaskDate(newTaskDates ?? _taskDates);
    fromDB = false;
  }

  void updateComplete(DsTask newTask) {
    if (_id == newTask.id) {
      _name = newTask._name;
      _emoji = newTask._emoji;
      _onEveryDate = newTask._onEveryDate;
      _offset = newTask._offset;
      _isImportant = newTask._isImportant;
      _timeFrom = newTask._timeFrom;
      _timeUntil = newTask._timeUntil;
      _repeatingTemplate = newTask._repeatingTemplate;
      _taskOwners = newTask._taskOwners;
      _updateTaskDate(newTask._taskDates);
      fromDB = false;
    }
  }

  DsTask copyWith({
    String? newName,
    String? newEmoji,
    bool? newOnEveryDate,
    int? newType,
    int? newOffset,
    bool? newIsImportant,
    TimeOfDay? newTimeFrom,
    TimeOfDay? newTimeUntil,
    DsRepeatingTemplates? newRepeatingTemplate,
    List<DsAccount>? newTaskOwners,
    List<DsTaskDate>? newTaskDates,
  }) {
    return DsTask(
      id: _id,
      name: newName ?? _name,
      emoji: newEmoji ?? _emoji,
      onEveryDate: newOnEveryDate ?? _onEveryDate,
      offset: newOffset ?? _offset,
      isImportant: newIsImportant ?? _isImportant,
      timeFrom: newTimeFrom ?? _timeFrom,
      timeUntil: newTimeUntil ?? _timeUntil,
      repeatingTemplate: newRepeatingTemplate ?? _repeatingTemplate,
      taskOwners: newTaskOwners ?? _taskOwners,
      taskDates: newTaskDates ?? _taskDates,
    );
  }
}
