import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsTaskDate {
  late String _id;
  late DateTime _plannedDate;
  late DateTime? _doneDate;
  late List<DsAccount>? _doneBy;
  late DsTask _task;

  bool fromDB;

  DsTaskDate({
    String? id,
    required DateTime plannedDate,
    required DsTask task,
    DateTime? doneDate,
    List<DsAccount>? doneBy,
    this.fromDB = false,
  }) {
    id = id ?? uuid();
    _plannedDate = plannedDate;
    _task = task;
    _doneDate = doneDate;
    _doneBy = doneBy;
  }

  String get id => _id;
  DateTime get plannedDate => _plannedDate.add(Duration(days: _task.offset));
  DateTime? get doneDate => _doneDate;
  List<DsAccount>? get doneBy => _doneBy;
  DsTask get task => _task;

  void update({
    DateTime? newPlannedDate,
    int? newCompletionWindow,
    DateTime? newDoneDate,
    List<DsAccount>? newDoneBy,
  }) {
    _plannedDate = newPlannedDate ?? _plannedDate;
    _doneDate = newDoneDate ?? _doneDate;
    _doneBy = newDoneBy ?? _doneBy;
    fromDB = false;
  }

  void updateComplete(DsTaskDate taskDate) {
    if (_id == taskDate.id) {
      _plannedDate = taskDate.plannedDate;
      _doneDate = taskDate.doneDate;
      _doneBy = taskDate.doneBy;
      _task = taskDate.task;
      fromDB = false;
    }
  }

  DsTaskDate copyWith({
    DateTime? newPlannedDate,
    int? newCompletionWindow,
    DateTime? newDoneDate,
    List<DsAccount>? newDoneBy,
    DsTask? newTask,
  }) {
    return DsTaskDate(
      id: _id,
      plannedDate: newPlannedDate ?? _plannedDate,
      doneDate: newDoneDate ?? _doneDate,
      doneBy: newDoneBy ?? _doneBy,
      task: newTask ?? _task,
    );
  }

  void markDone(DsAccount account) {
    _doneBy = [...(_doneBy ?? []), account];
    _doneDate = DateTime.now();
  }

  bool isDoneToday() {
    if (_doneDate == null) return false;
    final today = DateTime.now();
    return _doneDate!.year == today.year &&
        _doneDate!.month == today.month &&
        _doneDate!.day == today.day;
  }
}
