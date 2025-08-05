import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ETimePicker extends StatelessWidget {
  const ETimePicker({super.key, required this.time});

  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ColorScheme.light(
          primary: buttonColor,
          onSurface: textTitleColor,
        ),
        timePickerTheme: TimePickerThemeData(
          dayPeriodColor: buttonColor,
          dayPeriodTextColor: textColor,
          dayPeriodBorderSide: BorderSide(color: buttonColor, width: 1),
          helpTextStyle: buttonNormal,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(textStyle: buttonNormal),
        ),
      ),
      child: TimePickerDialog(initialTime: time),
    );
  }
}
