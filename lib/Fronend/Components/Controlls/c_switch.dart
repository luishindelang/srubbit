import 'package:flutter/material.dart';

class CSwitch extends StatelessWidget {
  const CSwitch({
    super.key,
    required this.value,
    required this.onchanged,
    this.acitveColor = Colors.black,
    this.acitveTrackColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.inactiveTrackColor = Colors.black,
    this.borderColor = Colors.transparent,
  });

  final bool value;
  final Function(bool) onchanged;
  final Color acitveColor;
  final Color acitveTrackColor;
  final Color inactiveColor;
  final Color inactiveTrackColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: acitveColor,
      activeTrackColor: acitveTrackColor,
      inactiveThumbColor: inactiveColor,
      inactiveTrackColor: inactiveTrackColor,
      trackOutlineColor: WidgetStateProperty.all(borderColor),
      thumbIcon: WidgetStateProperty.all(Icon(null)),
      value: value,
      onChanged: onchanged,
    );
  }
}
