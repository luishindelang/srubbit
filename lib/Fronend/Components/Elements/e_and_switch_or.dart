import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_switch.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EAndSwitchOr extends StatelessWidget {
  const EAndSwitchOr({super.key, required this.isOr, required this.onChange});

  final bool isOr;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CButton(
          onPressed: () => onChange(false),
          backgroundColor: Colors.transparent,
          forgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Text("Und", style: !isOr ? switchSelected : switchUnselected),
        ),
        CSwitch(
          value: isOr,
          onchanged: onChange,
          acitveColor: scaffoldBackgroundColor,
          inactiveColor: scaffoldBackgroundColor,
          acitveTrackColor: buttonColor,
          inactiveTrackColor: buttonColor,
          scale: 40,
        ),
        CButton(
          onPressed: () => onChange(true),
          backgroundColor: Colors.transparent,
          forgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          paddingVert: 0,
          child: Text("Oder", style: isOr ? switchSelected : switchUnselected),
        ),
      ],
    );
  }
}
