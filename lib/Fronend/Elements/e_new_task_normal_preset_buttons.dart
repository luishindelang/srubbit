import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

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
          text: "Heute",
          isSelected: type == 0,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(1),
          text: "Morgen",
          isSelected: type == 1,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(2),
          text: "Diese Woche",
          isSelected: type == 2,
          selectedBackground: buttonColor,
        ),
        ESelectAccountButton(
          onPressed: () => onChange(3),
          text: "Diesen Monat",
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
                  color: type == 4 ? textColor : buttonColor,
                ),
                SizedBox(width: 5),
                Text("Anderes Datum", style: buttonSelect),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
