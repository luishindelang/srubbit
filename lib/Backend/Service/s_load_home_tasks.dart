import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class SLoadHomeTasks {
  final List<DsTask> _todayTasks = [];
  final List<DsTask> _weekTasks = [];
  final List<DsTask> _monthTasks = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<DsTask> get todayTasks => _todayTasks;
  List<DsTask> get weekTasks => _weekTasks;
  List<DsTask> get monthTasks => _monthTasks;

  void addNewTask(DsTask newTask) {
    if (newTask.taskDates.isEmpty) return;

    final dates = newTask.taskDates
        .where((taskDate) =>
            (taskDate.doneBy?.isEmpty ?? true) && taskDate.doneDate == null)
        .toList();

    if (dates.isEmpty) return;

    dates.sort((a, b) => a.plannedDate.compareTo(b.plannedDate));
    final planned = dates.first.plannedDate.add(Duration(days: newTask.offset));

    if (isToday(planned)) {
      _todayTasks.add(newTask);
    } else if (isInCurrentWeek(planned)) {
      _weekTasks.add(newTask);
    } else if (isInCurrentMonth(planned)) {
      _monthTasks.add(newTask);
    }
  }

  bool removeTask(DsTask oldTask) {
    return _todayTasks.remove(oldTask) ||
        _weekTasks.remove(oldTask) ||
        _monthTasks.remove(oldTask);
  }

  void updateTask(DsTask oldTask, DsTask newTask) {
    if (removeTask(oldTask)) {
      addNewTask(newTask);
    }
  }

  Future<void> loadData() async {
    var dbService = await DatabaseService.init();
    var tasks = await dbService.daoTasks.getAll();
    for (var task in tasks) {
      addNewTask(task);
    }
    _isLoaded = true;
  }
}
