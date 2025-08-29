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
    if (newTask.taskDates.isNotEmpty) {
      List<DsTaskDate> dates = [];
      for (var taskDate in newTask.taskDates) {
        if (taskDate.doneBy == null && taskDate.doneDate == null) {
          dates.add(taskDate);
        } else if (!newTask.onEveryDate) {
          break;
        }
      }
      var duration = Duration(days: newTask.offset);
      var date = dates.last;
      var first = dates.first;
      if (isToday(date.plannedDate.add(duration))) {
        _todayTasks.add(newTask);
      } else if (isInCurrentWeek(date.plannedDate.add(duration))) {
        _weekTasks.add(newTask);
      } else if (isInCurrentMonth(first.plannedDate.add(duration)) ||
          isInCurrentMonth(date.plannedDate.add(duration))) {
        _monthTasks.add(newTask);
      }
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
