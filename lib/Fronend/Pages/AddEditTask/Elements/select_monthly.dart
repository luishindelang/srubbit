import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_date_picker.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class SelectMonthly extends StatelessWidget {
  const SelectMonthly({super.key, this.withShowSelect = false});
  final bool withShowSelect;

  String allSelectedMonthDates(List<DateTime> dates) {
    String finalData = "";
    for (var date in dates) {
      if (finalData.isNotEmpty) finalData += ", ";
      finalData += "${date.day}.";
    }
    return finalData;
  }

  @override
  Widget build(BuildContext context) {
    final createTask = context.watch<UiCreateTask>();
    String showSelectedTime() {
      if (createTask.selectedDates.isNotEmpty) {
        DateTime from = createTask.selectedDates.first;
        DateTime to = createTask.selectedDates.last;
        bool monthFrom = false;
        bool monthTo = true;
        if (from.month != to.month) monthFrom = true;
        bool yearFrom = false;
        bool yearTo = true;
        if (from.year != to.year) yearFrom = true;

        return "${formatDateDay(from, monthFrom, yearFrom)} - ${formatDateDay(to, monthTo, yearTo)}";
      }
      return "Select date(s)";
    }

    void openDatePicker() {
      showDialog(
        context: context,
        builder: (context) => EDatePicker(createTask: createTask),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: withShowSelect,
          child: ESelectAccountButton(
            onPressed: createTask.onSelectCompleteMonth,
            text: "Select specific days",
            isSelected: !createTask.completeMonth,
            selectedBackground: buttonColor,
          ),
        ),
        Visibility(
          visible: !createTask.completeMonth || !withShowSelect,
          child: InkWell(
            onTap: openDatePicker,
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              width: createTask.selectedDates.isEmpty ? 180 : 660,
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
                            createTask.selectedDates.isEmpty
                                ? ""
                                : createTask.isOr
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
                          groupByMonth(createTask.selectedDates).map((dates) {
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
