import 'package:flutter/material.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.textColor = Colors.black,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w500,
    this.cursorHeight = 26,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double cursorHeight;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      cursorColor: textColor,
      cursorHeight: cursorHeight,
      cursorRadius: Radius.circular(2),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor.withValues(alpha: 0.6),
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
