import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';

class CTextButtonSelected extends StatelessWidget {
  const CTextButtonSelected({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
    this.fontSize = 18,
    this.frontWeight = FontWeight.w400,
    this.background = Colors.white,
    this.backgroundSelected = Colors.black,
    this.textColor = Colors.black,
    this.textColorSelected = Colors.white,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final double fontSize;
  final FontWeight frontWeight;
  final Color background;
  final Color backgroundSelected;
  final Color textColor;
  final Color textColorSelected;

  @override
  Widget build(BuildContext context) {
    return CButton(
      onPressed: onPressed,
      backgroundColor: isSelected ? backgroundSelected : background,
      forgroundColor: isSelected ? textColorSelected : textColor,
      splashColor:
          isSelected
              ? backgroundSelected.withAlpha(120)
              : background.withAlpha(120),
      paddingHor: 14,
      paddingVert: 5,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: frontWeight),
      ),
    );
  }
}
