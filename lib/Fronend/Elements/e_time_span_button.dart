import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ETimeSpanButton extends StatelessWidget {
  const ETimeSpanButton({
    super.key,
    required this.isTimeSpan,
    required this.onPressed,
  });

  final bool isTimeSpan;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingButton),
      child: CButton(
        onPressed: onPressed,
        backgroundColor: isTimeSpan ? buttonColor : scaffoldBackgroundColor,
        splashColor: buttonSplashColor,
        radius: borderRadiusButtons,
        paddingHor: 14,
        paddingVert: 6,
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 22,
              color: isTimeSpan ? textNegativeColor : buttonColor,
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 22,
              color: isTimeSpan ? textNegativeColor : buttonColor,
            ),
            SizedBox(width: 5),
            Text(
              "Zeitspanne",
              style: isTimeSpan ? buttonSelected : buttonSelect,
            ),
          ],
        ),
      ),
    );
  }
}
