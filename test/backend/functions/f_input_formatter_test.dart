import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/Functions/f_input_formatter.dart';

void main() {
  group('NoLeadingZeroFormatter', () {
    final formatter = NoLeadingZeroFormatter();

    test('allows empty field', () {
      expect(
        formatter.formatEditUpdate(
          TextEditingValue.empty,
          const TextEditingValue(text: ''),
        ),
        const TextEditingValue(text: ''),
      );
    });

    test('rejects input that starts with zero', () {
      final oldValue = const TextEditingValue(text: '1');
      final newValue = const TextEditingValue(text: '01');
      expect(formatter.formatEditUpdate(oldValue, newValue), oldValue);
    });

    test('accepts non-zero input', () {
      final oldValue = const TextEditingValue(text: '1');
      final newValue = const TextEditingValue(text: '12');
      expect(formatter.formatEditUpdate(oldValue, newValue), newValue);
    });
  });
}
