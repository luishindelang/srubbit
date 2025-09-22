import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

void main() {
  DsTask buildTask({
    int offset = 0,
    DsRepeatingTemplates? template,
  }) {
    return DsTask(
      name: 'Task',
      emoji: '😀',
      onEveryDate: false,
      offset: offset,
      isImportant: true,
      timeFrom: const TimeOfDay(hour: 9, minute: 0),
      timeUntil: const TimeOfDay(hour: 10, minute: 0),
      repeatingTemplate: template,
      taskDates: [],
    );
  }

  DsTaskDate buildDate(DsTask task, DateTime date) {
    return DsTaskDate(
      plannedDate: date,
      task: task,
    );
  }

  test('addTaskDate tracks newly added items', () {
    final task = buildTask();
    final date = buildDate(task, DateTime(2024, 1, 1));

    task.addTaskDate(date);

    expect(task.taskDates, contains(date));
    expect(task.addTaskDates, contains(date));
  });

  test('removeTaskDate differentiates between fresh and persisted entries', () {
    final task = buildTask();
    final persisted = buildDate(task, DateTime(2024, 2, 1));
    task.setTaskDates = [persisted];

    final fresh = buildDate(task, DateTime(2024, 3, 1));
    task.addTaskDate(fresh);
    task.removeTaskDate(fresh);

    expect(task.addTaskDates, isEmpty);
    expect(task.removedTaskDates, isEmpty);

    task.removeTaskDate(persisted);
    expect(task.removedTaskDates, [persisted]);
    expect(task.taskDates, isEmpty);
  });

  test('clearTaskDate removes everything but keeps history', () {
    final task = buildTask();
    final date1 = buildDate(task, DateTime(2024, 4, 3));
    final date2 = buildDate(task, DateTime(2024, 4, 1));
    task.setTaskDates = [date1, date2];

    task.clearTaskDate();

    expect(task.taskDates, isEmpty);
    expect(task.removedTaskDates, containsAll([date1, date2]));
    expect(task.addTaskDates, isEmpty);
  });

  test('resetTaskDate restores previous entries sorted by date', () {
    final task = buildTask();
    final date1 = buildDate(task, DateTime(2024, 5, 4));
    final date2 = buildDate(task, DateTime(2024, 5, 2));
    task.setTaskDates = [date1, date2];
    task.clearTaskDate();

    task.resetTaskDate();

    expect(task.removedTaskDates, isEmpty);
    expect(task.taskDates, [date2, date1]);
  });

  test('savedToDb clears tracking lists', () {
    final task = buildTask();
    final date = buildDate(task, DateTime(2024, 6, 1));
    task.addTaskDate(date);
    task.removeTaskDate(date);

    task.savedToDb();

    expect(task.addTaskDates, isEmpty);
    expect(task.removedTaskDates, isEmpty);
  });

  test('update changes fields and synchronises task dates', () {
    final task = buildTask(offset: 1);
    final date1 = buildDate(task, DateTime(2024, 7, 1));
    final date2 = buildDate(task, DateTime(2024, 7, 2));
    task.setTaskDates = [date1, date2];

    final newOwner = DsAccount(name: 'Owner', color: Colors.red);
    final replacement = buildDate(task, DateTime(2024, 7, 3));

    task.update(
      newName: 'Updated Task',
      newEmoji: '🎉',
      newOnEveryDate: true,
      newOffset: 2,
      newIsImportant: false,
      newTimeFrom: const TimeOfDay(hour: 8, minute: 0),
      newTimeUntil: const TimeOfDay(hour: 9, minute: 0),
      newTaskOwners: [newOwner],
      newTaskDates: [date2, replacement],
    );

    expect(task.name, 'Updated Task');
    expect(task.emoji, '🎉');
    expect(task.onEveryDate, isTrue);
    expect(task.offset, 2);
    expect(task.isImportant, isFalse);
    expect(task.timeFrom, const TimeOfDay(hour: 8, minute: 0));
    expect(task.timeUntil, const TimeOfDay(hour: 9, minute: 0));
    expect(task.taskOwners, [newOwner]);
    expect(task.taskDates.map((d) => d.plannedDate),
        containsAll([date2.plannedDate, replacement.plannedDate]));
    expect(task.addTaskDates.length, 1);
    expect(task.addTaskDates.first.plannedDate, replacement.plannedDate);
    expect(task.removedTaskDates.length, 1);
    expect(task.removedTaskDates.first.plannedDate, date1.plannedDate);
    expect(task.fromDB, isFalse);
  });

  test('copyWith creates deep copy of fields', () {
    final owner = DsAccount(name: 'Owner', color: Colors.blue);
    final template = DsRepeatingTemplates(
      repeatingType: 1,
      repeatingIntervall: 1,
      repeatAfterDone: true,
      startDate: DateTime(2024, 1, 1),
      repeatingDates: [DsRepeatingTemplatesDates(weekDay: DateTime.monday)],
    );
    final task = buildTask(template: template);
    final date = buildDate(task, DateTime(2024, 1, 1));
    task.setTaskDates = [date];
    task.update(newTaskOwners: [owner]);

    final copy = task.copyWith(newName: 'Clone');

    expect(copy.id, task.id);
    expect(copy.name, 'Clone');
    expect(copy.repeatingTemplate, isNot(same(template)));
    expect(copy.repeatingTemplate!.repeatingType, template.repeatingType);
    expect(copy.taskOwners, isNot(same(task.taskOwners)));
    expect(copy.taskDates, isNot(same(task.taskDates)));
    expect(copy.taskDates.first.task, isNot(task));
    expect(task.name, isNot('Clone'));
  });

  test('updateComplete copies all values when ids match', () {
    final template = DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 1,
      repeatAfterDone: false,
      startDate: DateTime(2024, 1, 1),
    );
    final task = buildTask(template: template);
    final replacement = DsTask(
      id: task.id,
      name: 'Replacement',
      emoji: '🙂',
      onEveryDate: true,
      offset: 3,
      isImportant: false,
      timeFrom: const TimeOfDay(hour: 6, minute: 0),
      timeUntil: const TimeOfDay(hour: 7, minute: 0),
      repeatingTemplate: template.copyWith(newRepeatAfterDone: true),
      taskOwners: [DsAccount(name: 'Owner', color: Colors.green)],
      taskDates: [],
    );
    replacement.setTaskDates = [buildDate(replacement, DateTime(2024, 2, 1))];

    task.updateComplete(replacement);

    expect(task.name, 'Replacement');
    expect(task.onEveryDate, isTrue);
    expect(task.offset, 3);
    expect(task.repeatingTemplate!.repeatAfterDone, isTrue);
    expect(task.taskOwners!.first.name, 'Owner');
    expect(task.taskDates.length, 1);
    expect(task.fromDB, isFalse);
  });

  test('createRepeatingDates expands repeating template dates', () {
    final template = DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 1,
      repeatAfterDone: false,
      startDate: getNowWithoutTime(),
    );
    final task = buildTask(template: template);

    task.createRepeatingDates();

    expect(task.taskDates, isNotEmpty);
    expect(task.taskDates.first.task, task);
  });
}
