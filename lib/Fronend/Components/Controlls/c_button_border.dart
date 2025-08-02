import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';

class CButtonBorder extends StatelessWidget {
  const CButtonBorder({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.forgroundColor = Colors.black,
    this.splashColor = Colors.black38,
    this.borderColor = Colors.black,
    this.boxBorderWidth = 1,
    this.radius = 1,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final Color borderColor;
  final double boxBorderWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: boxBorderWidth),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: CButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        forgroundColor: forgroundColor,
        splashColor: splashColor,
        radius: radius,
        child: child,
      ),
    );
  }
}
