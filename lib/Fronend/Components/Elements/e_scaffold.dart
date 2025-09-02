import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_action_floating_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EScaffold extends StatelessWidget {
  const EScaffold({
    super.key,
    required this.weekday,
    required this.date,
    required this.onSettingsPressed,
    required this.settingsIcon,
    required this.body,
    this.onAddPressed,
  });

  final String weekday;
  final String date;
  final VoidCallback? onAddPressed;
  final VoidCallback onSettingsPressed;
  final IconData settingsIcon;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(weekday, style: scaffoldAppBarTitleBold),
                Text(", $date", style: scaffoldAppBarTitleNormal),
              ],
            ),
            Row(
              children: [
                CButton(
                  onPressed: onSettingsPressed,
                  backgroundColor: scaffoldBackgroundColor,
                  radius: 100,
                  paddingHor: 1,
                  paddingVert: 1,
                  child: Icon(settingsIcon, size: 38, color: buttonColor),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                scaffoldTopBarGradient1,
                scaffoldTopBarGradient1,
                scaffoldTopBarGradient2,
                scaffoldTopBarGradient3,
              ],
            ),
            boxShadow: [shadowScaffoldAppbar],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingScaffold),
        child: body,
      ),
      floatingActionButton:
          onAddPressed != null
              ? EActionFloatingButton(onAddPressed: onAddPressed!)
              : null,
    );
  }
}
