import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

class SLoadHomeTasks {
  final List<DsTaskDate> _todayTasks = [];
  final List<DsTaskDate> _weekTasks = [];
  final List<DsTaskDate> _monthTasks = [];

  final List<DsTaskDate> _missedTasks = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<DsTaskDate> get todayTasks => _todayTasks;
  List<DsTaskDate> get weekTasks => _weekTasks;
  List<DsTaskDate> get monthTasks => _monthTasks;

  List<DsTaskDate> get missedTasks => _missedTasks;

  void addNewTask(DsTask newTask) {
    if (newTask.taskDates.isEmpty) return;

    var now = DateTime.now();

    for (var taskDate in newTask.taskDates) {
      var date = taskDate.plannedDate.add(Duration(days: newTask.offset));
      if (date.isBefore(now)) {
        taskDate.task = newTask;
        _missedTasks.add(taskDate);
        continue;
      } else if (isToday(date)) {
        taskDate.task = newTask;
        _todayTasks.add(taskDate);
      } else if (isInCurrentWeek(date)) {
        taskDate.task = newTask;
        _weekTasks.add(taskDate);
      } else if (isInCurrentMonth(date)) {
        taskDate.task = newTask;
        _monthTasks.add(taskDate);
      }
      if (!newTask.onEveryDate) break;
    }
  }

  bool removeTask(DsTask oldTask) {
    return _todayTasks.remove(oldTask) ||
        _weekTasks.remove(oldTask) ||
        _monthTasks.remove(oldTask) ||
        _missedTasks.remove(oldTask);
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
