import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';

void main() {
  DsTask buildTask({int offset = 0}) {
    return DsTask(
      name: 'Task',
      emoji: '😀',
      onEveryDate: false,
      offset: offset,
      isImportant: true,
      timeFrom: const TimeOfDay(hour: 9, minute: 0),
      timeUntil: const TimeOfDay(hour: 10, minute: 0),
      taskDates: [],
    );
  }

  test('plannedDate applies task offset', () {
    final task = buildTask(offset: 2);
    final date = DsTaskDate(
      plannedDate: DateTime(2024, 1, 1),
      task: task,
    );

    expect(date.plannedDate, DateTime(2024, 1, 3));
  });

  test('update changes stored values and marks instance dirty', () {
    final task = buildTask();
    final taskDate = DsTaskDate(
      plannedDate: DateTime(2024, 1, 1),
      task: task,
      fromDB: true,
    );
    final account = DsAccount(name: 'Tester', color: Colors.blue);
    final newDate = DateTime(2024, 1, 5);

    taskDate.update(
      newPlannedDate: newDate,
      newDoneDate: newDate,
      newDoneBy: [account],
    );

    expect(taskDate.plannedDate, newDate);
    expect(taskDate.doneDate, newDate);
    expect(taskDate.doneBy, [account]);
    expect(taskDate.fromDB, isFalse);
  });

  test('updateComplete copies everything from matching task date', () {
    final task = buildTask();
    final otherTask = buildTask(offset: 1);
    final original = DsTaskDate(
      plannedDate: DateTime(2024, 1, 1),
      task: task,
    );
    final replacement = DsTaskDate(
      id: original.id,
      plannedDate: DateTime(2024, 2, 1),
      doneDate: DateTime(2024, 2, 3),
      doneBy: [DsAccount(name: 'A', color: Colors.red)],
      task: otherTask,
      fromDB: true,
    );

    original.updateComplete(replacement);

    expect(original.plannedDate, replacement.plannedDate);
    expect(original.doneDate, replacement.doneDate);
    expect(original.task, otherTask);
    expect(original.fromDB, isFalse);
  });

  test('copyWith creates detached copy sharing the id', () {
    final task = buildTask();
    final account = DsAccount(name: 'Copy', color: Colors.green);
    final original = DsTaskDate(
      plannedDate: DateTime(2024, 3, 1),
      task: task,
      doneBy: [account],
    );

    final copy = original.copyWith(
      newPlannedDate: DateTime(2024, 3, 2),
      newDoneDate: DateTime(2024, 3, 3),
      newDoneBy: [],
      newTask: task,
    );

    expect(copy.id, original.id);
    expect(copy.plannedDate, DateTime(2024, 3, 2));
    expect(copy.doneDate, DateTime(2024, 3, 3));
    expect(copy.doneBy, isEmpty);
    expect(original.plannedDate, DateTime(2024, 3, 1));
    expect(original.doneBy, [account]);
  });

  test('markDone adds account and sets done date to today', () {
    final task = buildTask();
    final account = DsAccount(name: 'Worker', color: Colors.orange);
    final date = DsTaskDate(
      plannedDate: DateTime(2024, 4, 1),
      task: task,
    );

    date.markDone(account);

    expect(date.doneBy, contains(account));
    expect(date.doneDate, isNotNull);
    expect(date.isDoneToday(), isTrue);
  });
}
