import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';

class MappingTask {
  final DaoTaskDate daoTaskDate;
  final DaoRepeatingTemplates daoRepeatingTemplates;
  final DaoAccount daoAccount;

  MappingTask(this.daoTaskDate, this.daoRepeatingTemplates, this.daoAccount);

  Future<DsTask> fromMap(Map<String, dynamic> rawData) async {
    final repeatingTemplateId = rawData[TTask.repeatingTemplateId] as String?;
    final repeatingTemplate =
        repeatingTemplateId != null
            ? await daoRepeatingTemplates.get(repeatingTemplateId)
            : null;
    final taskDates = await daoTaskDate.getByTaskId(rawData[TTask.id]);
    final taskOwned = await daoAccount.get(rawData[TTask.taskOwnerId]);
    final doneBy = await daoAccount.getDoneBy(rawData[TTask.id]);

    return DsTask(
      id: rawData[TTask.id],
      name: rawData[TTask.name],
      emoji: rawData[TTask.emoji],
      onEveryDate: rawData[TTask.onEveryDate] == 1,
      taskDates: taskDates,
      offset: rawData[TTask.offset],
      isImportant: rawData[TTask.isImportant] == 1,
      timeFrom:
          rawData[TTask.timeFrom] != null
              ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeFrom])
              : null,
      timeUntil:
          rawData[TTask.timeUntil] != null
              ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeUntil])
              : null,
      repeatingTemplate: repeatingTemplate,
      taskOwned: taskOwned,
      doneDate:
          rawData[TTask.doneDate] != null
              ? DateTime.fromMillisecondsSinceEpoch(rawData[TTask.timeFrom])
              : null,
      doneBy: doneBy.isNotEmpty ? doneBy : null,
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
      TTask.emoji: task.emoji,
      TTask.onEveryDate: task.onEveryDate ? 1 : 0,
      TTask.offset: task.offset,
      TTask.isImportant: task.isImportant ? 1 : 0,
      TTask.timeFrom: task.timeFrom?.millisecondsSinceEpoch,
      TTask.timeUntil: task.timeUntil?.millisecondsSinceEpoch,
      TTask.repeatingTemplateId: task.repeatingTemplate?.id,
      TTask.taskOwnerId: task.taskOwned?.id,
      TTask.doneDate: task.doneDate?.millisecondsSinceEpoch,
    };
  }
}
