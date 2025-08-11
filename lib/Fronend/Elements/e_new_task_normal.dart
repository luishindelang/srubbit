import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskNormal extends StatefulWidget {
  const ENewTaskNormal({
    super.key,
    required this.onChangeType,
    required this.onChangeSelected,
    required this.onChangeOrAnd,
  });

  final void Function(int) onChangeType;
  final void Function(List<DateTime>) onChangeSelected;
  final void Function(bool) onChangeOrAnd;

  @override
  State<ENewTaskNormal> createState() => _ENewTaskNormalState();
}

class _ENewTaskNormalState extends State<ENewTaskNormal> {
  int type = 0;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
      widget.onChangeType(type);
    });
  }

  Widget showTypeElements() {
    switch (type) {
      case 2:
        return ENewTaskNormalWeekly(
          onChangeOrAnd: widget.onChangeOrAnd,
          onChangeSelected: widget.onChangeSelected,
        );
      case 3:
        return ENewTaskNormalMonthly(
          onChangeSelected: widget.onChangeSelected,
          onChangeOrAnd: widget.onChangeOrAnd,
        );
      case 4:
        return ENewTaskNormalMonthly(
          onChangeSelected: widget.onChangeSelected,
          onChangeOrAnd: widget.onChangeOrAnd,
        );
      default:
        return const SizedBox(height: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding - 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ENewTaskNormalPresetButtons(type: type, onChange: onChangeType),
          SizedBox(height: 20),
          showTypeElements(),
        ],
      ),
    );
  }
}
