import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task_date.dart';

class MappingTaskDate {
  final DaoAccount daoAccount;

  MappingTaskDate(this.daoAccount);

  Future<DsTaskDate> fromMap(Map<String, dynamic> rawData) async {
    final doneBy = await daoAccount.getDoneBy(rawData[TTaskDate.id]);
    return DsTaskDate(
      id: rawData[TTaskDate.id],
      plannedDate: DateTime.fromMillisecondsSinceEpoch(
        rawData[TTaskDate.plannedDate],
      ),
      completionWindow: rawData[TTaskDate.completionWindow],
      doneDate:
          rawData[TTaskDate.doneDate] != null
              ? DateTime.fromMillisecondsSinceEpoch(rawData[TTaskDate.doneDate])
              : null,
      doneBy: doneBy.isNotEmpty ? doneBy : null,
      fromDB: true,
    );
  }

  Future<List<DsTaskDate>> fromList(List<Map<String, dynamic>> rawData) async {
    List<DsTaskDate> finalData = [];
    for (var value in rawData) {
      finalData.add(await fromMap(value));
    }
    return finalData;
  }

  Map<String, dynamic> toMap(DsTaskDate taskDate, String? taskId) {
    return {
      TTaskDate.id: taskDate.id,
      TTaskDate.plannedDate: taskDate.plannedDate.millisecondsSinceEpoch,
      TTaskDate.completionWindow: taskDate.completionWindow,
      TTaskDate.taskId: taskId,
      TTaskDate.doneDate: taskDate.doneDate?.millisecondsSinceEpoch,
    };
  }
}
