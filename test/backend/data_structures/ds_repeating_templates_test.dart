import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

void main() {
  DsRepeatingTemplates buildTemplate() {
    return DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 1,
      repeatingCount: null,
      repeatAfterDone: false,
      startDate: DateTime(2024, 1, 1),
      endDate: null,
      lastDoneDate: null,
      repeatingDates: [],
    );
  }

  test('update modifies every field and resets fromDB', () {
    final template = buildTemplate();
    template.update(
      newRepeatingType: 1,
      newRepeatingIntervall: 2,
      newRepeatingCount: 5,
      newRepeatAfterDone: true,
      newStartDate: DateTime(2024, 2, 1),
      newEndDate: DateTime(2024, 3, 1),
      newLastDoneDate: DateTime(2024, 2, 2),
      newRepeatingDates: [DsRepeatingTemplatesDates(weekDay: DateTime.monday)],
    );

    expect(template.repeatingType, 1);
    expect(template.repeatingIntervall, 2);
    expect(template.repeatingCount, 5);
    expect(template.repeatAfterDone, isTrue);
    expect(template.startDate, DateTime(2024, 2, 1));
    expect(template.endDate, DateTime(2024, 3, 1));
    expect(template.lastDoneDate, DateTime(2024, 2, 2));
    expect(template.repeatingDates.length, 1);
    expect(template.fromDB, isFalse);
  });

  test('copyWith clones template while keeping id', () {
    final template = buildTemplate();
    final copy = template.copyWith(
      newRepeatingType: 3,
      newRepeatingIntervall: 4,
      newRepeatingCount: 6,
      newRepeatAfterDone: true,
      newStartDate: DateTime(2025, 1, 1),
      newEndDate: DateTime(2025, 2, 1),
      newLastDoneDate: DateTime(2025, 1, 15),
    );

    expect(copy.id, template.id);
    expect(copy.repeatingType, 3);
    expect(copy.repeatingIntervall, 4);
    expect(copy.repeatingCount, 6);
    expect(copy.repeatAfterDone, isTrue);
    expect(copy.startDate, DateTime(2025, 1, 1));
    expect(copy.endDate, DateTime(2025, 2, 1));
    expect(copy.lastDoneDate, DateTime(2025, 1, 15));
    expect(template.repeatingType, 0);
  });

  test('updateComplete copies everything from another template', () {
    final original = buildTemplate();
    final replacement = DsRepeatingTemplates(
      id: original.id,
      repeatingType: 2,
      repeatingIntervall: 5,
      repeatingCount: 8,
      repeatAfterDone: true,
      startDate: DateTime(2024, 4, 1),
      endDate: DateTime(2024, 5, 1),
      lastDoneDate: DateTime(2024, 4, 10),
      repeatingDates: [DsRepeatingTemplatesDates(monthDay: 15)],
    );

    original.updateComplete(replacement);

    expect(original.repeatingType, 2);
    expect(original.repeatingIntervall, 5);
    expect(original.repeatingCount, 8);
    expect(original.repeatAfterDone, isTrue);
    expect(original.startDate, DateTime(2024, 4, 1));
    expect(original.endDate, DateTime(2024, 5, 1));
    expect(original.lastDoneDate, DateTime(2024, 4, 10));
    expect(original.repeatingDates.length, 1);
    expect(original.fromDB, isFalse);
  });

  test('getDates daily returns start date when not completed yet', () {
    final startDate = getNowWithoutTime().subtract(const Duration(days: 3));
    final template = DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 1,
      repeatAfterDone: false,
      startDate: startDate,
      lastDoneDate: null,
      repeatingDates: [],
    );

    final dates = template.getDates();
    expect(dates, [startDate]);
  });

  test('getDates daily with repeatAfterDone true schedules after completion', () {
    final today = getNowWithoutTime();
    final template = DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 2,
      repeatAfterDone: true,
      startDate: today.subtract(const Duration(days: 5)),
      lastDoneDate: today.subtract(const Duration(days: 1)),
      repeatingDates: [],
    );

    final dates = template.getDates();
    expect(dates.single, template.lastDoneDate!.add(const Duration(days: 2)));
  });

  test('getDates daily without repeatAfterDone lists missed and next dates', () {
    final today = getNowWithoutTime();
    final template = DsRepeatingTemplates(
      repeatingType: 0,
      repeatingIntervall: 2,
      repeatAfterDone: false,
      startDate: today.subtract(const Duration(days: 5)),
      lastDoneDate: today.subtract(const Duration(days: 4)),
      repeatingDates: [],
    );

    final dates = template.getDates();
    expect(dates.length, 2);
    expect(dates[0], today.add(const Duration(days: 1)));
    expect(dates[1], today.add(const Duration(days: 3)));
  });

  test('getDates returns start date when no repeating dates configured', () {
    final template = DsRepeatingTemplates(
      repeatingType: 1,
      repeatingIntervall: 1,
      repeatAfterDone: false,
      startDate: DateTime(2024, 1, 1),
      repeatingDates: [],
    );

    expect(template.getDates(), [DateTime(2024, 1, 1)]);
  });

  test('getDates weekly returns upcoming configured days', () {
    final today = getNowWithoutTime();
    final datesConfig = [
      DsRepeatingTemplatesDates(weekDay: today.weekday),
      DsRepeatingTemplatesDates(weekDay: (today.weekday % 7) + 1),
    ];
    final template = DsRepeatingTemplates(
      repeatingType: 1,
      repeatingIntervall: 1,
      repeatAfterDone: false,
      startDate: today.subtract(const Duration(days: 14)),
      repeatingDates: datesConfig,
    );

    final dates = template.getDates();
    final daysSinceStart = today.difference(template.startDate).inDays;
    final daysToNext = (daysSinceStart ~/ 7) % template.repeatingIntervall;

    final expected = datesConfig
        .map((config) => config.getDate(daysToNext))
        .whereType<DateTime>()
        .toList();

    expect(dates, expected);
  });
}
