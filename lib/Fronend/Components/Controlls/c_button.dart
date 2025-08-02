import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.forgroundColor = Colors.black,
    this.splashColor = Colors.black38,
    this.paddingVert = 2,
    this.paddingHor = 6,
    this.radius = 1,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final double paddingVert;
  final double paddingHor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHor,
          vertical: paddingVert,
        ),

        backgroundColor: backgroundColor,
        foregroundColor: forgroundColor,
        overlayColor: splashColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
