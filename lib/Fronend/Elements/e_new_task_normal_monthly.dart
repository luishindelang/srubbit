import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_date_picker.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class ENewTaskNormalMonthly extends StatefulWidget {
  const ENewTaskNormalMonthly({
    super.key,
    required this.onChangeSelected,
    required this.onChangeOrAnd,
    this.withShowSelect = false,
    this.isOr = false,
  });

  final void Function(List<DateTime>) onChangeSelected;
  final void Function(bool) onChangeOrAnd;
  final bool withShowSelect;
  final bool isOr;

  @override
  State<ENewTaskNormalMonthly> createState() => _ENewTaskNormalMonthlyState();
}

class _ENewTaskNormalMonthlyState extends State<ENewTaskNormalMonthly> {
  List<DateTime> selectedDates = [];
  bool? isTimeSpann;
  bool? isOr;

  bool showSelection = false;

  void openDatePicker() {
    showDialog(
      context: context,
      builder:
          (context) => EDatePicker(
            selectedDates: selectedDates,
            isTimeSpan: isTimeSpann,
            isOr: isOr,
          ),
    ).then(
      (data) => setState(() {
        if (data != null) {
          selectedDates = data["dates"];
          isTimeSpann = data["isTimeSpan"];
          isOr = data["isOr"];
          selectedDates.sort((a, b) => a.compareTo(b));
          widget.onChangeSelected(selectedDates);
          widget.onChangeOrAnd(isOr!);
        }
      }),
    );
  }

  String showSelectedTime() {
    if (selectedDates.isNotEmpty && isOr != null && isTimeSpann != null) {
      DateTime from = selectedDates.first;
      DateTime to = selectedDates.last;
      bool monthFrom = false;
      bool monthTo = true;
      if (from.month != to.month) monthFrom = true;
      bool yearFrom = false;
      bool yearTo = true;
      if (from.year != to.year) yearFrom = true;

      if (isTimeSpann!) {
        return "${formatDateDay(from, monthFrom, yearFrom)} - ${formatDateDay(to, monthTo, yearTo)}";
      } else {
        String fromDate = formatDate(from, monthFrom, yearFrom);
        if (fromDate.isNotEmpty) {
          fromDate += " - ";
        }
        return "$fromDate${formatDate(to, monthTo, yearTo)}";
      }
    }
    return "Select date(s)";
  }

  String allSelectedMonthDates(List<DateTime> dates) {
    String finalData = "";
    for (var date in dates) {
      if (finalData.isNotEmpty) finalData += ", ";
      finalData += "${date.day}.";
    }
    return finalData;
  }

  @override
  void initState() {
    isOr = widget.isOr;
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
                }),
            text: "Select specific days",
            isSelected: showSelection,
            selectedBackground: buttonColor,
          ),
        ),
        Visibility(
          visible: showSelection || !widget.withShowSelect,
          child: InkWell(
            onTap: openDatePicker,
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              width: selectedDates.isEmpty ? 180 : 660,
              decoration: BoxDecoration(
                color: taskListBackgroundColor,
                borderRadius: BorderRadius.circular(borderRadiusBox),
                border: Border.all(width: 1.5, color: buttonColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadiusBox),
                        topRight: Radius.circular(borderRadiusBox),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 5.0,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: buttonColor,
                                size: 20,
                              ),
                              Text(
                                showSelectedTime(),
                                style: selectedCalendarTitle,
                              ),
                            ],
                          ),
                          Text(
                            isOr == null
                                ? ""
                                : isOr!
                                ? "ODER"
                                : "UND",
                            style: selectedCalendarTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 15,
                    ),
                    child: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          groupByMonth(selectedDates).map((dates) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    allSelectedMonthDates(dates),
                                    style: selectedCalendarDays,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    monthNames[dates.first.month - 1],
                                    style: selectedCalendarMonths,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
