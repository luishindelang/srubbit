import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_button_selected.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ESelectAccountButton extends StatelessWidget {
  const ESelectAccountButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
    required this.selectedBackground,
    this.withShadow = false,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final Color selectedBackground;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingButton),
      child: Container(
        decoration:
            withShadow
                ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusButtons),
                  boxShadow: [shadowTaskElement],
                )
                : null,
        child: CTextButtonSelected(
          onPressed: onPressed,
          text: text,
          isSelected: isSelected,
          fontSize: buttonSelect.fontSize!,
          fontWeight: buttonSelect.fontWeight!,
          textColor: buttonSelect.color!,
          textColorSelected: textNegativeColor,
          background: buttonBackgroundColor,
          backgroundSelected: selectedBackground,
          radius: borderRadiusButtons,
        ),
      ),
    );
  }
}
