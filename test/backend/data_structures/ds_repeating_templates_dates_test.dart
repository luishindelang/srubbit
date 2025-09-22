import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

void main() {
  test('getDate returns correct yearly date with overflow adjustment', () {
    final dates = DsRepeatingTemplatesDates(month: 2, monthDay: 30);
    final today = getNowWithoutTime();
    final expectedDay = adjustDayForMonth(30, 2, today.year + 1);
    expect(dates.getDate(1), DateTime(today.year + 1, 2, expectedDay));
  });

  test('getDate returns monthly date within same month', () {
    final dates = DsRepeatingTemplatesDates(monthDay: 31);
    final today = getNowWithoutTime();
    final base = DateTime(today.year, today.month, 1);
    final expectedDay = adjustDayForMonth(31, base.month, base.year);
    expect(dates.getDate(0), DateTime(base.year, base.month, expectedDay));
  });

  test('getDate calculates weekly occurrences relative to today', () {
    final targetWeekday = DateTime.friday;
    final dates = DsRepeatingTemplatesDates(weekDay: targetWeekday);
    final today = getNowWithoutTime();
    final delta = (targetWeekday - today.weekday + DateTime.daysPerWeek) %
        DateTime.daysPerWeek;
    final anchor = today.add(Duration(days: delta));

    expect(dates.getDate(0), anchor);
    expect(dates.getDate(2), anchor.add(const Duration(days: 14)));
  });

  test('getDate returns null when no configuration provided', () {
    final dates = DsRepeatingTemplatesDates();
    expect(dates.getDate(0), isNull);
  });
}
