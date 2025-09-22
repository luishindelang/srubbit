import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';

void main() {
  group('format helpers', () {
    test('formatDateTime pads hour and minute with leading zeros', () {
      final dateTime = DateTime(2024, 1, 2, 5, 7);
      expect(formatDateTime(dateTime), '05:07');
    });

    test('formatDate handles optional month and year parts', () {
      final date = DateTime(2024, 3, 15);
      expect(formatDate(date, true, true), 'März 2024');
      expect(formatDate(date, false, true), ' 2024');
      expect(formatDate(date, false, false), '');
    });

    test('formatDateDay builds dd.mm.yyyy strings', () {
      final date = DateTime(2024, 11, 9);
      expect(formatDateDay(date, true, true), '09.11.2024');
      expect(formatDateDay(date, false, false), '09');
    });

    test('formatTime renders TimeOfDay values', () {
      const time = TimeOfDay(hour: 4, minute: 9);
      expect(formatTime(time), '04:09');
    });
  });

  group('time conversions', () {
    test('timeOfDayToInt converts to minute count and back', () {
      const time = TimeOfDay(hour: 13, minute: 37);
      final totalMinutes = timeOfDayToInt(time);
      expect(totalMinutes, 13 * 60 + 37);
      expect(timeOfDayToInt(null), isNull);

      final restored = intToTimeOfDay(totalMinutes);
      expect(restored!.hour, 13);
      expect(restored.minute, 37);
      expect(intToTimeOfDay(null), isNull);
    });
  });

  group('date list builders', () {
    test('getNext7Weekdays returns consecutive dates starting today', () {
      final now = DateTime.now();
      final expectedStart = DateTime(now.year, now.month, now.day);
      final result = getNext7Weekdays();

      expect(result.length, 7);
      for (var i = 0; i < result.length; i++) {
        final expected = expectedStart.add(Duration(days: i));
        expect(result[i], expected);
      }
    });

    test('groupByMonth separates dates per month preserving order', () {
      final dates = [
        DateTime(2024, 1, 1),
        DateTime(2024, 1, 15),
        DateTime(2024, 2, 1),
        DateTime(2024, 2, 10),
      ];

      final grouped = groupByMonth(dates);
      expect(grouped.length, 2);
      expect(grouped[0], [dates[0], dates[1]]);
      expect(grouped[1], [dates[2], dates[3]]);
    });

    test('datesUntilEndOfWeek contains every day until Sunday', () {
      final today = getNowWithoutTime();
      final dates = datesUntilEndOfWeek();

      expect(dates.first, today);
      for (var i = 0; i < dates.length; i++) {
        expect(dates[i], today.add(Duration(days: i)));
      }
      expect(dates.last.weekday, DateTime.sunday);
    });

    test('datesUntilEndOfMonth spans to the final day of month', () {
      final today = getNowWithoutTime();
      final dates = datesUntilEndOfMonth();
      final startOfNextMonth = today.month == 12
          ? DateTime(today.year + 1, 1, 1)
          : DateTime(today.year, today.month + 1, 1);
      final expectedLast = startOfNextMonth.subtract(const Duration(days: 1));

      expect(dates.first, today);
      expect(dates.last, expectedLast);
      expect(dates.length, expectedLast.difference(today).inDays + 1);
    });
  });

  group('relative day checks', () {
    test('isSameDay compares only calendar day components', () {
      final base = DateTime(2024, 6, 3, 10, 30);
      final other = DateTime(2024, 6, 3, 23, 59);
      expect(isSameDay(base, other), isTrue);
      expect(isSameDay(base, base.add(const Duration(days: 1))), isFalse);
    });

    test('isToday and isTomorrow follow current system date', () {
      expect(isToday(DateTime.now()), isTrue);
      expect(isTomorrow(DateTime.now().add(const Duration(days: 1))), isTrue);
      expect(isTomorrow(DateTime.now()), isFalse);
    });

    test('isInCurrentWeek returns true only for current week range', () {
      final today = getNowWithoutTime();
      final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      final inside = startOfWeek.add(const Duration(days: 2));
      final outside = startOfWeek.subtract(const Duration(days: 1));

      expect(isInCurrentWeek(inside), isTrue);
      expect(isInCurrentWeek(outside), isFalse);
    });

    test('isInCurrentMonth checks month and year against today', () {
      final today = getNowWithoutTime();
      final nextMonth = DateTime(today.year, today.month + 1, today.day);
      expect(isInCurrentMonth(today), isTrue);
      expect(isInCurrentMonth(nextMonth), isFalse);
    });

    test('allDaysUntilSundayIncluded validates provided list', () {
      final complete = datesUntilEndOfWeek();
      expect(allDaysUntilSundayIncluded(complete), isTrue);
      expect(allDaysUntilSundayIncluded(complete.sublist(0, complete.length - 1)),
          isFalse);
      expect(allDaysUntilSundayIncluded([]), isFalse);
    });

    test('allDaysUntilEndOfMonthIncluded validates full span', () {
      final allDays = datesUntilEndOfMonth();
      expect(allDaysUntilEndOfMonthIncluded(allDays), isTrue);
      expect(
        allDaysUntilEndOfMonthIncluded(allDays.sublist(0, allDays.length - 1)),
        isFalse,
      );
      expect(allDaysUntilEndOfMonthIncluded([]), isFalse);
    });
  });

  group('utility calculations', () {
    test('getNowWithoutTime applies offsets to current date', () {
      final now = DateTime.now();
      final expected = DateTime(now.year + 1, now.month + 1, now.day + 2);
      final result = getNowWithoutTime(addYear: 1, addMonth: 1, addDay: 2);
      expect(result, expected);
    });

    test('daysUntilEndOfWeek counts days based on weekday', () {
      final monday = DateTime(2024, 3, 4); // Monday
      expect(daysUntilEndOfWeek(monday), DateTime.daysPerWeek - monday.weekday);
    });

    test('daysUntilEndOfMonth uses month length for calculation', () {
      final date = DateTime(2024, 2, 20);
      expect(daysUntilEndOfMonth(date), 9);
    });

    test('addToDate supports multiple repeat types', () {
      final base = DateTime(2024, 1, 10);
      expect(addToDate(base, 0, 3), base.add(const Duration(days: 3)));
      expect(addToDate(base, 1, 2), base.add(const Duration(days: 14)));
      expect(addToDate(base, 2, 1), DateTime(2024, 2, 10));
      expect(addToDate(base, 3, 1), DateTime(2025, 1, 10));

      final fallback = addToDate(null, 99, 5);
      expect(fallback, getNowWithoutTime());
    });

    test('adjustDayForMonth clamps overflowing days to month length', () {
      expect(adjustDayForMonth(31, 4, 2024), 30);
      expect(adjustDayForMonth(29, 2, 2023), 28);
      expect(adjustDayForMonth(15, 6, 2024), 15);
    });

    test('monthDifference and yearDifference compute spans correctly', () {
      final from = DateTime(2023, 5, 1);
      final to = DateTime(2024, 8, 1);
      expect(monthDifference(from, to), 15);
      expect(yearDifference(from, to), 1);
    });
  });
}
