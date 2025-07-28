import 'package:scrubbit/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_task.dart';

class MappingTask {
  final DaoTaskDate daoTaskDate;
  final DaoRepeatingTemplates daoRepeatingTemplates;

  MappingTask(this.daoTaskDate, this.daoRepeatingTemplates);

  Future<DsTask> fromMap(Map<String, dynamic> rawData) async {
    final repeatingTemplateId = rawData[TTask.repeatingTemplateId] as String?;
    final repeatingTemplate = repeatingTemplateId != null
        ? await daoRepeatingTemplates.get(repeatingTemplateId)
        : null;
    final taskDates = await daoTaskDate.getByTaskId(rawData[TTask.id]);

    return DsTask(
      id: rawData[TTask.id],
      name: rawData[TTask.name],
      onEveryDate: rawData[TTask.onEveryDate] == 1,
      taskDates: taskDates,
      offsetDate: rawData[TTask.offsetDate] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.offsetDate])
          : null,
      timeFrom: rawData[TTask.timeFrom] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeFrom])
          : null,
      timeUntil: rawData[TTask.timeUntil] != null
          ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeUntil])
          : null,
      repeatingTemplate: repeatingTemplate,
      doneDate: null,
      doneBy: null,
      fromDB: true,
    );
  }

  Future<List<DsTask>> fromList(List<Map<String, dynamic>> rawData) async {
    List<DsTask> finalData = [];
    for (var value in rawData) {
      finalData.add(await fromMap(value));
    }
    return finalData;
  }

  Future<Map<String, dynamic>> toMap(DsTask task) async {
    return {
      TTask.id: task.id,
      TTask.name: task.name,
      TTask.onEveryDate: task.onEveryDate ? 1 : 0,
      TTask.offsetDate: task.offsetDate?.millisecondsSinceEpoch,
      TTask.timeFrom: task.timeFrom?.millisecondsSinceEpoch,
      TTask.timeUntil: task.timeUntil?.millisecondsSinceEpoch,
      TTask.repeatingTemplateId: task.repeatingTemplate?.id,
      TTask.taskOwnerId: task.taskOwned?.id,
    };
  }
}
