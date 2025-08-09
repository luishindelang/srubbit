import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_lists.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Elements/e_and_switch_or.dart';
import 'package:scrubbit/Fronend/Elements/e_time_span_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ENewTaskNormalWeekly extends StatefulWidget {
  const ENewTaskNormalWeekly({
    super.key,
    required this.onChangeOrAnd,
    required this.onSelectedWeekDays,
  });

  final void Function(bool) onChangeOrAnd;
  final void Function(List<String>) onSelectedWeekDays;

  @override
  State<ENewTaskNormalWeekly> createState() => _ENewTaskNormalWeeklyState();
}

class _ENewTaskNormalWeeklyState extends State<ENewTaskNormalWeekly> {
  late final List<String> weekDays;
  List<String> selectedWeekDays = [];
  bool isTimeSpan = false;
  bool isOr = false;

  void onOrAndChange(bool newIs) {
    setState(() {
      isOr = newIs;
      widget.onChangeOrAnd(isOr);
    });
  }

  void onSelectWeekDay(String day) {
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
            int to = weekDays.indexOf(day);
            int from = weekDays.indexOf(selectedWeekDays.last);
            for (var day in timeSpann(weekDays, from, to)) {
              selectedWeekDays.add(day);
            }
          } else {
            selectedWeekDays = [];
            selectedWeekDays.add(day);
          }
        }
      }
      widget.onSelectedWeekDays(selectedWeekDays);
    });
  }

  @override
  void initState() {
    weekDays = getNext7Weekdays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: Column(
        children: [
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
                                  day,
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
    );
  }
}
