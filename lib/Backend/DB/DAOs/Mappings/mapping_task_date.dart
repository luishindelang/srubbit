import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';

class MappingTaskDate {
  DsTaskDate fromMap(Map<String, dynamic> rawData) {
    return DsTaskDate(
      id: rawData[TTaskDate.id],
      plannedDate: DateTime.fromMillisecondsSinceEpoch(
        rawData[TTaskDate.plannedDate],
      ),
      completionWindow: rawData[TTaskDate.completionWindow],
      fromDB: true,
    );
  }

  List<DsTaskDate> fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(fromMap).toList();
  }

  Map<String, dynamic> toMap(DsTaskDate taskDate, String taskId) {
    return {
      TTaskDate.id: taskDate.id,
      TTaskDate.plannedDate: taskDate.plannedDate.millisecondsSinceEpoch,
      TTaskDate.completionWindow: taskDate.completionWindow,
      TTaskDate.taskId: taskId,
    };
  }
}
