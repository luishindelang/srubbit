import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';

class CDatePickerCalendar extends StatefulWidget {
  const CDatePickerCalendar({
    super.key,
    required this.currentMonth,
    required this.selectedDates,
    required this.onDatePressed,
    required this.weekDays,
    required this.monthNames,
    this.backgroundColor = Colors.white,
    this.topBackgroundColor = Colors.black12,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.borderRadius = 12,
    this.calendarBoxSize = 60,
    this.thisMonthStyle = const TextStyle(),
    this.iconColor = Colors.black,
    this.weekDayStyle = const TextStyle(),
    this.dateButtonStyleSelected = const TextStyle(),
    this.dateButtonStyleThisMonth = const TextStyle(),
    this.dateButtonStyleOtherMonth = const TextStyle(),
    this.dateIsSelected = Colors.blue,
    this.dateIsToday = Colors.black,
  });

  final DateTime currentMonth;
  final List<DateTime> selectedDates;
  final List<DateTime> Function(DateTime) onDatePressed;
  final List<String> weekDays;
  final List<String> monthNames;
  final Color backgroundColor;
  final Color topBackgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double calendarBoxSize;
  final TextStyle thisMonthStyle;
  final Color iconColor;
  final TextStyle weekDayStyle;
  final TextStyle dateButtonStyleSelected;
  final TextStyle dateButtonStyleThisMonth;
  final TextStyle dateButtonStyleOtherMonth;
  final Color dateIsSelected;
  final Color dateIsToday;

  @override
  State<CDatePickerCalendar> createState() => _CDatePickerCalendarState();
}

class _CDatePickerCalendarState extends State<CDatePickerCalendar> {
  var controller = PageController();

  late List<DateTime> _selectedDates;
  late DateTime _currentMonth;

  void setCurrentMonth(int index) {
    setState(() {
      _currentMonth = DateTime(
        DateTime.now().year,
        DateTime.now().month + index,
      );
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  void _goToNextMonth() {
    setState(() {
      controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  List<DateTime> _buildCalendarDays(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstWeekday =
        firstDayOfMonth.weekday == 7 ? 0 : firstDayOfMonth.weekday;
    final totalDays = lastDayOfMonth.day;

    final daysBefore = firstWeekday - 1;
    final totalBoxes = ((daysBefore + totalDays) / 7).ceil() * 7;

    return List.generate(totalBoxes, (index) {
      final day = index - daysBefore + 1;
      return DateTime(month.year, month.month, 1).add(Duration(days: day - 1));
    });
  }

  bool isSameDay(DateTime a, DateTime? b) =>
      a.year == b?.year && a.month == b?.month && a.day == b?.day;

  @override
  void initState() {
    _selectedDates = widget.selectedDates;
    _currentMonth = DateTime(
      widget.currentMonth.year,
      widget.currentMonth.month,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          width: widget.borderWidth,
          color: widget.borderColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.calendarBoxSize * 7,
            decoration: BoxDecoration(
              color: widget.topBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                topRight: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: widget.iconColor,
                    size: 40,
                  ),
                  onPressed: _goToPreviousMonth,
                ),
                Text(
                  "${widget.monthNames[_currentMonth.month - 1]}, ${_currentMonth.year}",
                  style: widget.thisMonthStyle,
                ),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: widget.iconColor,
                    size: 40,
                  ),
                  onPressed: _goToNextMonth,
                ),
              ],
            ),
          ),
          SizedBox(
            width: widget.calendarBoxSize * 7,
            height: widget.calendarBoxSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  widget.weekDays
                      .map((day) => Text(day, style: widget.weekDayStyle))
                      .toList(),
            ),
          ),

          SizedBox(
            width: widget.calendarBoxSize * 7,
            height: widget.calendarBoxSize * 5,
            child: PageView.builder(
              controller: controller,
              onPageChanged: setCurrentMonth,
              itemBuilder: (context, index) {
                var currentBuildMonth = DateTime(
                  DateTime.now().year,
                  DateTime.now().month + index,
                );
                var days = _buildCalendarDays(currentBuildMonth);
                return GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children:
                      days.map((date) {
                        final isToday = isSameDay(date, DateTime.now());
                        final isSelected = _selectedDates.contains(date);
                        final isInMonth = date.month == _currentMonth.month;
                        TextStyle styleDate() {
                          if (isSelected) return widget.dateButtonStyleSelected;
                          if (isInMonth) return widget.dateButtonStyleThisMonth;
                          return widget.dateButtonStyleOtherMonth;
                        }

                        return CButton(
                          paddingHor: 4,
                          paddingVert: 4,
                          radius: 100,
                          backgroundColor:
                              isSelected
                                  ? widget.dateIsSelected
                                  : isToday
                                  ? widget.dateIsToday
                                  : Colors.transparent,
                          onPressed:
                              () => setState(() {
                                _selectedDates = widget.onDatePressed(date);
                              }),
                          child: Center(
                            child: Text("${date.day}", style: styleDate()),
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
