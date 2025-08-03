import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_icon_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';

class EActionFloatingButton extends StatelessWidget {
  const EActionFloatingButton({super.key, required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [buttonAddTask],
      ),
      child: CIconButton(
        onPressed: onAddPressed,
        paddingHor: 0,
        paddingVert: 0,
        radius: 100,
        backgroundColor: buttonColor,
        icon: Icon(Icons.add_rounded, color: scaffoldBackgroundColor, size: 60),
      ),
    );
  }
}
