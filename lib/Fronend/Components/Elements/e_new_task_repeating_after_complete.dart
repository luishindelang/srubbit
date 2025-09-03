import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_switch.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ENewTaskRepeatingAfterComplete extends StatelessWidget {
  const ENewTaskRepeatingAfterComplete({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CSwitch(
          value: value,
          onchanged: onChanged,
          acitveColor: scaffoldBackgroundColor,
          inactiveColor: scaffoldBackgroundColor,
          acitveTrackColor: buttonColor,
          inactiveTrackColor: textInactiveColor,
          scale: 50,
        ),
        SizedBox(width: 10),
        Text(
          "after complete",
          style: value ? switchSelected : switchUnselected,
        ),
      ],
    );
  }
}
