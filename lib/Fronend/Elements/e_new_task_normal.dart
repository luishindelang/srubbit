import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskNormal extends StatefulWidget {
  const ENewTaskNormal({super.key});

  @override
  State<ENewTaskNormal> createState() => _ENewTaskNormalState();
}

class _ENewTaskNormalState extends State<ENewTaskNormal> {
  int type = 0;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding - 5,
      ),
      child: Column(
        children: [
          ENewTaskNormalPresetButtons(type: type, onChange: onChangeType),
        ],
      ),
    );
  }
}
