import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_date_picker_calendar.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_drop_down.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating_intervall.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class ENewTaskRepeatingSelectDate extends StatefulWidget {
  const ENewTaskRepeatingSelectDate({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onDatePressed,
    this.isEnd = false,
    this.startDate,
  });

  final String title;
  final DateTime? selectedDate;
  final void Function(DateTime?) onDatePressed;
  final bool isEnd;
  final DateTime? startDate;

  @override
  State<ENewTaskRepeatingSelectDate> createState() =>
      _ENewTaskRepeatingSelectDateState();
}

class _ENewTaskRepeatingSelectDateState
    extends State<ENewTaskRepeatingSelectDate> {
  late List<String> options;
  DateTime? selectedDate;
  DateTime? startDate;

  bool showAfter = false;
  int afterType = 0;
  int afterIntervall = 1;

  String showDate() {
    if (widget.selectedDate == null) {
      return "";
    }
    return formatDateDay(widget.selectedDate!, true, true);
  }

  void updateEndDate() {
    selectedDate = addToDate(startDate, afterType, afterIntervall);
    widget.onDatePressed(selectedDate);
  }

  void selectDate() {
    showDialog<DateTime>(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: scaffoldBackgroundColor,
            child: CDatePickerCalendar(
              currentMonth: DateTime(DateTime.now().year, DateTime.now().month),
              selectedDate: widget.selectedDate,
              onDatePressed: (newDate) {
                Navigator.pop(context, newDate);
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
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          selectedDate = newDate;
          widget.onDatePressed(newDate);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant ENewTaskRepeatingSelectDate oldWidget) {
    if (oldWidget.startDate != widget.startDate) {
      startDate = widget.startDate;
      updateEndDate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (!isSameDay(DateTime.now(), widget.selectedDate)) {
      selectedDate = widget.selectedDate;
    }
    if (widget.isEnd) {
      options = ["Never", "After", "Other date"];
    } else {
      options = ["Now", "Other date"];
    }
    startDate = widget.startDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: repeatingCategoryTitle),
        Row(
          children: [
            CDropDown(
              itemName: (itemValue) {
                return itemValue;
              },
              onChangedItem: (value) {
                if (value == options.last) {
                  setState(() {
                    showAfter = false;
                  });
                  selectDate();
                }
                if (value == options.first) {
                  setState(() {
                    selectedDate = null;
                    widget.onDatePressed(selectedDate);
                    showAfter = false;
                  });
                }
                if (value == "After") {
                  setState(() {
                    updateEndDate();
                    showAfter = true;
                  });
                }
              },
              options: options,
              selectedItemName: options.first,
              dropdownRadius: borderRadiusBox,
              background: buttonBackgroundColor,
              boxBorderWidth: 0,
              boxBorderColor: Colors.transparent,
              textStyle: buttonSelect,
              dropdownIconSize: 20,
              paddingHor: 14,
              paddingVert: 6,
              dropdownOffset: 42,
            ),
            SizedBox(width: 10),
            Visibility(
              visible: selectedDate != null && !showAfter,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 30,
                    color: buttonColor,
                  ),
                  SizedBox(width: 10),
                  Text(showDate(), style: buttonNormal),
                ],
              ),
            ),
            Visibility(
              visible: showAfter,
              child: ENewTaskRepeatingIntervall(
                onIntervallChanged: (newAfterIntervall) {
                  afterIntervall = newAfterIntervall;
                  selectedDate = addToDate(
                    widget.startDate,
                    afterType,
                    afterIntervall,
                  );
                  widget.onDatePressed(selectedDate);
                },
                repeatingIntervall: afterIntervall,
                onTypeChanged: (newAfterType) {
                  afterType = newAfterType;
                  updateEndDate();
                },
                repeatingType: afterType,
                showTitle: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
