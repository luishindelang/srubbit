import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_lists.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_and_switch_or.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_time_span_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class ENewTaskNormalWeekly extends StatefulWidget {
  const ENewTaskNormalWeekly({
    super.key,
    required this.taskService,
    this.withShowSelect = true,
    required this.weekDays,
  });

  final SCreateTask taskService;
  final bool withShowSelect;
  final List<DateTime> weekDays;

  @override
  State<ENewTaskNormalWeekly> createState() => _ENewTaskNormalWeeklyState();
}

class _ENewTaskNormalWeeklyState extends State<ENewTaskNormalWeekly> {
  List<DateTime> selectedWeekDays = [];
  bool isTimeSpan = false;
  bool isOr = false;

  bool showSelection = false;

  void onOrAndChange(bool newIs) {
    setState(() {
      isOr = newIs;
      widget.taskService.onChangeOrAnd(isOr);
    });
  }

  void onSelectWeekDay(DateTime day) {
    setState(() {
      if (!isTimeSpan) {
        if (selectedWeekDays.contains(day)) {
          selectedWeekDays.remove(day);
        } else {
          selectedWeekDays.add(day);
        }
      } else {
        if (selectedWeekDays.contains(day)) {
          selectedWeekDays = [];
        } else {
          if (selectedWeekDays.isEmpty) {
            selectedWeekDays.add(day);
          } else if (selectedWeekDays.length == 1) {
            int to = widget.weekDays.indexOf(day);
            int from = widget.weekDays.indexOf(selectedWeekDays.last);
            selectedWeekDays = [];
            selectedWeekDays.addAll(timeSpann(widget.weekDays, from, to));
          } else {
            selectedWeekDays = [];
            selectedWeekDays.add(day);
          }
        }
      }
      selectedWeekDays.sort((a, b) => a.compareTo(b));
      widget.taskService.onSelectedDates(selectedWeekDays);
    });
  }

  @override
  void initState() {
    selectedWeekDays = widget.taskService.selectedDates;
    isOr = widget.taskService.isOr;
    showSelection = selectedWeekDays.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.withShowSelect,
          child: ESelectAccountButton(
            onPressed:
                () => setState(() {
                  showSelection = !showSelection;
                  widget.taskService.completeWeek = showSelection;
                }),
            text: "Select weekdays",
            isSelected: showSelection,
            selectedBackground: buttonColor,
          ),
        ),
        Visibility(
          visible: showSelection || !widget.withShowSelect,
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
                                widget.weekDays.map((day) {
                                  return Container(
                                    margin: const EdgeInsets.all(paddingButton),
                                    decoration: BoxDecoration(
                                      boxShadow: [shadowTaskElement],
                                      borderRadius: BorderRadius.circular(
                                        borderRadiusButtons,
                                      ),
                                    ),
                                    child: CButton(
                                      onPressed: () => onSelectWeekDay(day),
                                      backgroundColor:
                                          selectedWeekDays.contains(day)
                                              ? buttonColor
                                              : scaffoldBackgroundColor,
                                      splashColor: buttonSplashColor,
                                      radius: borderRadiusButtons,
                                      paddingHor: 20,
                                      paddingVert: 6,
                                      child: Text(
                                        weekDays[day.weekday - 1],
                                        style:
                                            selectedWeekDays.contains(day)
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
                              EAndSwitchOr(isOr: isOr, onChange: onOrAndChange),
                              SizedBox(width: 146),
                              ETimeSpanButton(
                                isTimeSpan: isTimeSpan,
                                onPressed:
                                    () => setState(() {
                                      isTimeSpan = !isTimeSpan;
                                    }),
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
