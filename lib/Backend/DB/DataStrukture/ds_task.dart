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

  List<DsTaskDate> _taskDates = [];

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
    List<DsTaskDate>? taskDates,
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
    if (taskDates != null) _taskDates = taskDates;
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

  void addTaskDate(DsTaskDate newTaskDate) {
    addTaskDates.add(newTaskDate);
    _taskDates.add(newTaskDate);
  }

  void removeTaskDate(DsTaskDate taskDate) {
    bool removedNew = addTaskDates.remove(taskDate);
    _taskDates.remove(taskDate);
    if (!removedNew) {
      removedTaskDates.add(taskDate);
    }
  }

  void clearTaskDate() {
    removedTaskDates.addAll(_taskDates);
    addTaskDates.clear();
    _taskDates.clear();
  }

  void resetTaskDate() {
    addTaskDates.clear();
    _taskDates.addAll(removedTaskDates);
    _taskDates.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
    removedTaskDates.clear();
  }

  void savedToDb() {
    addTaskDates.clear();
    removedTaskDates.clear();
  }

  void _updateTaskDate(List<DsTaskDate> newTaskDates) {
    final desired = newTaskDates
        .map((d) => d.copyWith(newTask: this))
        .toList(growable: false);

    final current = List<DsTaskDate>.from(_taskDates, growable: false);

    bool sameDate(DsTaskDate a, DsTaskDate b) =>
        a.plannedDate.isAtSameMomentAs(b.plannedDate);

    for (final oldItem in current) {
      final stillWanted = desired.any((d) => sameDate(d, oldItem));
      if (!stillWanted) {
        removeTaskDate(oldItem);
      }
    }

    for (final want in desired) {
      final alreadyThere = _taskDates.any((d) => sameDate(d, want));
      if (!alreadyThere) {
        addTaskDate(want);
      }
    }

    _taskDates.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
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
      _name = newTask.name;
      _emoji = newTask.emoji;
      _onEveryDate = newTask.onEveryDate;
      _offset = newTask.offset;
      _isImportant = newTask.isImportant;
      _timeFrom = newTask.timeFrom;
      _timeUntil = newTask.timeUntil;
      _repeatingTemplate = newTask.repeatingTemplate;
      _taskOwners = newTask.taskOwners;
      _updateTaskDate(newTask.taskDates);
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
    final copied = DsTask(
      id: _id,
      name: newName ?? _name,
      emoji: newEmoji ?? _emoji,
      onEveryDate: newOnEveryDate ?? _onEveryDate,
      offset: newOffset ?? _offset,
      isImportant: newIsImportant ?? _isImportant,
      timeFrom: newTimeFrom ?? _timeFrom,
      timeUntil: newTimeUntil ?? _timeUntil,
      repeatingTemplate:
          (newRepeatingTemplate ?? _repeatingTemplate)?.copyWith(),
      taskOwners: (newTaskOwners ?? _taskOwners)?.toList(growable: true),
      taskDates: (newTaskDates ?? _taskDates)
          .map((d) => d.copyWith())
          .toList(growable: true),
    );

    for (var i = 0; i < copied.taskDates.length; i++) {
      copied.taskDates[i] = copied.taskDates[i].copyWith(newTask: copied);
    }

    return copied;
  }
}
