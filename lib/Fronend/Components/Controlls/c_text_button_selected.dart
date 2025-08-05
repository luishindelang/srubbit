import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';

class CTextButtonSelected extends StatelessWidget {
  const CTextButtonSelected({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
    this.background = Colors.white,
    this.backgroundSelected = Colors.black,
    this.textColor = Colors.black,
    this.textColorSelected = Colors.white,
    this.radius = 10,
    this.paddingHor = 14,
    this.paddingVert = 6,
  });

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;
  final double fontSize;
  final FontWeight fontWeight;
  final Color background;
  final Color backgroundSelected;
  final Color textColor;
  final Color textColorSelected;
  final double radius;
  final double paddingHor;
  final double paddingVert;

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
      paddingHor: paddingHor,
      paddingVert: paddingVert,
      radius: radius,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
