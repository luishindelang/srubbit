import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
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
      var date = newTask.taskDates.last;
      if (isToday(date.plannedDate.add(Duration(days: newTask.offset)))) {
        _todayTasks.add(newTask);
      } else if (isInCurrentWeek(
        date.plannedDate.add(Duration(days: newTask.offset)),
      )) {
        _weekTasks.add(newTask);
      } else {
        _monthTasks.add(newTask);
      }
    }
  }

  void removeTask(DsTask oldTask) {
    _todayTasks.remove(oldTask);
    _weekTasks.remove(oldTask);
    _monthTasks.remove(oldTask);
  }

  void updateTask(DsTask oldTask, DsTask newTask) {
    removeTask(oldTask);
    addNewTask(newTask);
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
