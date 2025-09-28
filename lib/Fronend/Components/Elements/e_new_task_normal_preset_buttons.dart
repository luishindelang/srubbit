import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';

class ENewTaskNormalPresetButtons extends StatelessWidget {
  const ENewTaskNormalPresetButtons({
    super.key,
    required this.onChange,
    required this.type,
  });

  final void Function(int) onChange;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ESelectAccountButton(
          onPressed: () => onChange(0),
          text: textToday,
          isSelected: type == 0,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(1),
          text: textTomorrow,
          isSelected: type == 1,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(2),
          text: textThisWeek,
          isSelected: type == 2,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(3),
          text: textThisMonth,
          isSelected: type == 3,
          selectedBackground: buttonColor,
        ),
        Padding(
          padding: const EdgeInsets.all(paddingButton),
          child: CButton(
            onPressed: () => onChange(4),
            backgroundColor: type == 4 ? buttonColor : buttonBackgroundColor,
            splashColor: Colors.transparent,
            radius: borderRadiusButtons,
            paddingHor: 14,
            paddingVert: 6,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 22,
                  color: type == 4 ? textNegativeColor : buttonColor,
                ),
                SizedBox(width: 5),
                Text(
                  textOtherDatePreset,
                  style: type == 4 ? buttonSelected : buttonSelect,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
