import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.selectionColor = Colors.black45,
    this.textColor = Colors.black,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w500,
    this.cursorHeight = 26,
    this.textInputType,
    this.inputFormatter,
    this.onSubmitted,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final String hintText;
  final Color textColor;
  final Color selectionColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double cursorHeight;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: textColor,
          selectionColor: selectionColor,
          selectionHandleColor: textColor,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: inputFormatter,
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
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        focusNode: focusNode,
      ),
    );
  }
}
