import 'package:flutter/services.dart';

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Erlaubt leeres Feld
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Wenn der erste Charakter '0' ist → Eingabe ignorieren
    if (newValue.text.startsWith('0')) {
      return oldValue;
    }

    return newValue;
  }
}
