import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_button_selected.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ESelectAccountButton extends StatelessWidget {
  const ESelectAccountButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
    required this.selectedBackground,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final Color selectedBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingButton),
      child: CTextButtonSelected(
        onPressed: onPressed,
        text: text,
        isSelected: isSelected,
        fontSize: 18,
        frontWeight: FontWeight.w400,
        textColor: textColor,
        textColorSelected: textNegativeColor,
        background: buttonBackgroundColor,
        backgroundSelected: selectedBackground,
        radius: borderRadiusButtons,
      ),
    );
  }
}
