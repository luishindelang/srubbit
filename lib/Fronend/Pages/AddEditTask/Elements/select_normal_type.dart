import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/select_monthly.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/select_weekly.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class SelectNormalType extends StatefulWidget {
  const SelectNormalType({super.key, required this.type});

  final int type;

  @override
  State<SelectNormalType> createState() => _SelectNormalTypeState();
}

class _SelectNormalTypeState extends State<SelectNormalType> {
  late int type;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
    });
  }

  Widget showTypeElements() {
    switch (type) {
      case 2:
        return SelectWeekly(weekDays: getNext7Weekdays());
      case 3:
        return SelectMonthly(withShowSelect: true);
      case 4:
        return SelectMonthly();
      default:
        return const SizedBox(height: 20);
    }
  }

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createTask = context.read<UiCreateTask>();
    createTask.onSetType(type);
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
