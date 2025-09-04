import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Backend/Functions/f_lists.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_ranged_date_picker_calendar.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_and_switch_or.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_time_span_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class EDatePicker extends StatefulWidget {
  const EDatePicker({super.key, required this.createTask});

  final UiCreateTask createTask;

  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  List<DateTime> selectedDates = [];
  bool isTimeSpan = false;
  bool isOr = false;

  bool canBeDone = false;

  void onDone() {
    if (canBeDone) {
      widget.createTask.onSelectedDates(selectedDates);
      Navigator.pop(context);
    }
  }

  List<DateTime> onSelectMonthDay(DateTime date) {
    if (date.isBefore(getNowWithoutTime())) return selectedDates;
    if (!isTimeSpan) {
      if (selectedDates.contains(date)) {
        selectedDates.remove(date);
      } else {
        selectedDates.add(date);
      }
    } else {
      if (selectedDates.contains(date)) {
        selectedDates = [];
      } else {
        if (selectedDates.isEmpty) {
          selectedDates.add(date);
        } else if (selectedDates.length == 1) {
          DateTime from = selectedDates.first;
          DateTime to = date;
          selectedDates = dateTimeSpann(from, to);
        } else {
          selectedDates = [];
          selectedDates.add(date);
        }
      }
    }
    setState(() {
      if (selectedDates.isNotEmpty) {
        canBeDone = true;
      } else {
        canBeDone = false;
      }
    });
    return selectedDates;
  }

  @override
  void initState() {
    selectedDates = widget.createTask.selectedDates;
    isOr = widget.createTask.isOr;
    if (selectedDates.isNotEmpty) {
      canBeDone = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          CRangedDatePickerCalendar(
            currentMonth: DateTime(DateTime.now().year, DateTime.now().month),
            selectedDates: selectedDates,
            onDatePressed: onSelectMonthDay,
            weekDays: weekDaysText,
            monthNames: monthNames,
            backgroundColor: scaffoldBackgroundColor,
            topBackgroundColor: taskListBackgroundColor,
            borderRadius: borderRadiusBox,
            borderColor: buttonColor,
            borderWidth: 1.5,
            calendarBoxSize: calendarBoxSize,
            thisMonthStyle: calendarThisMonth,
            iconColor: buttonColor,
            weekDayStyle: calendarWeekDays,
            dateButtonStyleSelected: calendarSelected,
            dateButtonStyleThisMonth: calendarThisMonth,
            dateButtonStyleOtherMonth: calendarOtherMonth,
            dateIsSelected: buttonColor,
            dateIsToday: scaffoldTopBarGradient1,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: EAndSwitchOr(
                  isOr: isOr,
                  onChange:
                      (newIsOr) => setState(() {
                        isOr = newIsOr;
                        widget.createTask.onChangeIsOr(newIsOr);
                      }),
                ),
              ),
              SizedBox(width: 10),
              ETimeSpanButton(
                isTimeSpan: isTimeSpan,
                onPressed:
                    () => setState(() {
                      isTimeSpan = !isTimeSpan;
                    }),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: onDone,
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: sizeDoneButtonNewTask,
                    height: sizeDoneButtonNewTask,
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [shadowTaskElement],
                    ),
                    child:
                        canBeDone ? FAssets.doneActive : FAssets.doneInactive,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
