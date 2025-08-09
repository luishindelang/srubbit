import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_date_picker_calendar.dart';
import 'package:scrubbit/Fronend/Elements/e_and_switch_or.dart';
import 'package:scrubbit/Fronend/Elements/e_time_span_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class EDatePicker extends StatefulWidget {
  const EDatePicker({super.key});

  @override
  State<EDatePicker> createState() => _EDatePickerState();
}

class _EDatePickerState extends State<EDatePicker> {
  List<DateTime> selectedDates = [];
  bool isTimeSpan = false;
  bool isOr = false;

  bool canBeDone = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CDatePickerCalendar(
              currentMonth: DateTime(DateTime.now().year, DateTime.now().month),
              selectedDates: selectedDates,
              onDatePressed: (date) {
                if (selectedDates.contains(date)) {
                  selectedDates.remove(date);
                } else {
                  selectedDates.add(date);
                }
                return selectedDates;
              },
              weekDays: weekDays,
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
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
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
              EAndSwitchOr(isOr: isOr, onChange: (newIsOr) {}),
              SizedBox(width: 30),
              ETimeSpanButton(
                isTimeSpan: isTimeSpan,
                onPressed:
                    () => setState(() {
                      isTimeSpan = !isTimeSpan;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {},
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
