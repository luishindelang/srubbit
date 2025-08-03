import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EDoneBottons extends StatelessWidget {
  const EDoneBottons({
    super.key,
    required this.canBeDone,
    required this.onEdit,
    required this.onDone,
    required this.onNext,
  });

  final bool canBeDone;
  final VoidCallback onEdit;
  final VoidCallback onDone;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: sizeDoneBottonsOutside,
                height: sizeDoneBottonsOutside,
                child: Icon(
                  Icons.mode_edit_outline_rounded,
                  color: buttonColor,
                  size: 70,
                  shadows: [shadowIconDoneButtons],
                ),
              ),
            ),
            SizedBox(width: spaceBetweenButtons),
            InkWell(
              onTap: onDone,
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: sizeDoneBottonMiddle,
                height: sizeDoneBottonMiddle,
                child:
                    canBeDone
                        ? FAssets.completeActive
                        : FAssets.completeInactive,
              ),
            ),
            SizedBox(width: spaceBetweenButtons),
            InkWell(
              onTap: onNext,
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: sizeDoneBottonsOutside,
                height: sizeDoneBottonsOutside,
                child: Icon(
                  Icons.double_arrow_rounded,
                  color: buttonColor,
                  size: 90,
                  shadows: [shadowIconDoneButtons],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: sizeDoneBottonsOutside,
              child: Center(
                child: Text("Bearbeiten", style: taskPopupDescription),
              ),
            ),
            SizedBox(width: spaceBetweenButtons),
            SizedBox(
              width: sizeDoneBottonMiddle,
              child: Center(
                child: Text(
                  "Geschafft!",
                  style:
                      canBeDone
                          ? taskPopupDoneDescriptionActive
                          : taskPopupDoneDescriptionInactive,
                ),
              ),
            ),
            SizedBox(width: spaceBetweenButtons),
            SizedBox(
              width: sizeDoneBottonsOutside,
              child: Center(
                child: Text("Verschieben", style: taskPopupDescription),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
