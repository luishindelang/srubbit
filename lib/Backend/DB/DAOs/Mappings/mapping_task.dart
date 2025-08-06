import 'package:scrubbit/Backend/DB/DAOs/dao_account.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DAOs/dao_task_date.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

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
    final taskOwners = await daoAccount.getOwners(rawData[TTask.id]);

    return DsTask(
      id: rawData[TTask.id] as String,
      name: rawData[TTask.name] as String,
      emoji: rawData[TTask.emoji] as String,
      onEveryDate: rawData[TTask.onEveryDate] == 1,
      taskDates: taskDates,
      offset: rawData[TTask.offset],
      isImportant: rawData[TTask.isImportant] == 1,
      timeFrom: intToTimeOfDay(rawData[TTask.timeFrom]),
      timeUntil: intToTimeOfDay(rawData[TTask.timeUntil]),
      repeatingTemplate: repeatingTemplate,
      taskOwners: taskOwners,
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
      TTask.timeFrom: timeOfDayToInt(task.timeFrom),
      TTask.timeUntil: timeOfDayToInt(task.timeUntil),
      TTask.repeatingTemplateId: task.repeatingTemplate?.id,
    };
  }
}
