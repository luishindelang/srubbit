import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_and_switch_or.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_switch_time_span_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class SelectWeekly extends StatelessWidget {
  const SelectWeekly({
    super.key,
    this.withShowSelect = true,
    required this.weekDays,
    required this.type,
  });

  final bool withShowSelect;
  final List<DateTime> weekDays;
  final int type;

  @override
  Widget build(BuildContext context) {
    final createTask = context.watch<UiCreateTask>();
    createTask.onSetType(type);
    print(createTask.selectedDates);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: withShowSelect,
          child: ESelectAccountButton(
            onPressed: createTask.onSelectCompleteWeek,
            text: "Select weekdays",
            isSelected: !createTask.completeWeek,
            selectedBackground: buttonColor,
          ),
        ),
        Visibility(
          visible: !createTask.completeWeek || !withShowSelect,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        scaffoldBackgroundColor,
                        buttonColor,
                        buttonColor,
                        buttonColor,
                        scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        scaffoldBackgroundColor,
                        taskListBackgroundColor,
                        taskListBackgroundColor,
                        taskListBackgroundColor,
                        scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 40,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11),
                        child: Icon(Icons.sunny, size: 24, color: buttonColor),
                      ),
                      Column(
                        children: [
                          Row(
                            children:
                                weekDays.map((day) {
                                  return Container(
                                    margin: const EdgeInsets.all(paddingButton),
                                    decoration: BoxDecoration(
                                      boxShadow: [shadowTaskElement],
                                      borderRadius: BorderRadius.circular(
                                        borderRadiusButtons,
                                      ),
                                    ),
                                    child: CButton(
                                      onPressed:
                                          () => createTask.onSelectWeekDay(
                                            day,
                                            weekDays,
                                          ),
                                      backgroundColor:
                                          createTask.selectedDates.contains(day)
                                              ? buttonColor
                                              : scaffoldBackgroundColor,
                                      splashColor: buttonSplashColor,
                                      radius: borderRadiusButtons,
                                      paddingHor: 20,
                                      paddingVert: 6,
                                      child: Text(
                                        weekDaysText[day.weekday - 1],
                                        style:
                                            createTask.selectedDates.contains(
                                                  day,
                                                )
                                                ? buttonSelected
                                                : buttonSelect,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              EAndSwitchOr(
                                isOr: createTask.isOr,
                                onChange: createTask.onChangeIsOr,
                              ),
                              SizedBox(width: 146),
                              ESwitchTimeSpanButton(
                                isTimeSpan: createTask.isTimeSpan,
                                onChange: createTask.onChangeTimeSpan,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(paddingButton),
                        child: CButton(
                          onPressed: () {},
                          backgroundColor: Colors.transparent,
                          splashColor: buttonSplashColor,
                          radius: borderRadiusButtons,
                          paddingHor: 14,
                          paddingVert: 10,
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: textPassiveColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        scaffoldBackgroundColor,
                        buttonColor,
                        buttonColor,
                        buttonColor,
                        scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
