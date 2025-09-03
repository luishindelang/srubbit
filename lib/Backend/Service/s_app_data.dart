import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';

class SAppData {
  static final SAppData instance = SAppData._constructor();
  SAppData._constructor();

  final todayTasks = <DsTaskDate>[];
  final weekTasks = <DsTaskDate>[];
  final monthTasks = <DsTaskDate>[];
  final missedTasks = <DsTaskDate>[];
  final accounts = <DsAccount>[];
  final repeatingTasks = <DsTask>[];

  void loadData() async {}
}
