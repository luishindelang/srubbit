import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/Functions/f_lists.dart';

void main() {
  group('rotate', () {
    test('rotates list forward from given index', () {
      expect(rotate([1, 2, 3, 4], 2), [3, 4, 1, 2]);
    });

    test('supports negative start positions by wrapping', () {
      expect(rotate([1, 2, 3, 4], -1), [4, 1, 2, 3]);
    });
  });

  group('timeSpann', () {
    test('returns contiguous segment when from <= to', () {
      expect(timeSpann([0, 1, 2, 3, 4], 1, 3), [1, 2, 3]);
    });

    test('wraps around when from is greater than to', () {
      expect(timeSpann([0, 1, 2, 3, 4], 3, 1), [3, 4, 0, 1]);
    });
  });

  group('dateTimeSpann', () {
    test('produces inclusive range when from is before to', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2024, 1, 3);
      expect(dateTimeSpann(from, to), [from, from.add(const Duration(days: 1)), to]);
    });

    test('swaps order when from is after to', () {
      final from = DateTime(2024, 1, 5);
      final to = DateTime(2024, 1, 2);
      final result = dateTimeSpann(from, to);
      expect(result.first, to);
      expect(result.last, from);
      expect(result.length, 4);
    });
  });
}
