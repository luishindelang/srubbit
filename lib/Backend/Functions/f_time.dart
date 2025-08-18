import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

String formatDateTime(DateTime dateTime) {
  return "${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";
}

String formatDate(DateTime dateTime, bool withMonth, bool withYear) {
  String month = "";
  String year = "";
  if (withYear) year = " ${dateTime.year}";
  if (withMonth) month = monthNames[dateTime.month - 1].padLeft(2, "0");
  return "$month$year";
}

String formatDateDay(DateTime dateTime, bool withMonth, bool withYear) {
  String month = "";
  String year = "";
  if (withYear) year = ".${dateTime.year}";
  if (withMonth) month = ".${dateTime.month.toString().padLeft(2, "0")}";
  return "${dateTime.day.toString().padLeft(2, "0")}$month$year";
}

String formatTime(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
}

int? timeOfDayToInt(TimeOfDay? time) {
  if (time == null) return null;
  return time.hour * 60 + time.minute;
}

TimeOfDay? intToTimeOfDay(int? value) {
  if (value == null) return null;
  final hour = value ~/ 60;
  final min = value % 60;
  return TimeOfDay(hour: hour, minute: min);
}

List<DateTime> getNext7Weekdays() {
  DateTime today = DateTime.now();
  return List.generate(
    7,
    (index) => DateTime(today.year, today.month, today.day + index),
  );
}

List<List<DateTime>> groupByMonth(List<DateTime> dates) {
  List<List<DateTime>> finalList = [];
  int? lastMonth;
  List<DateTime> newMonthList = [];
  for (var date in dates) {
    if (lastMonth == null) {
      lastMonth = date.month;
      newMonthList.add(date);
    } else if (lastMonth == date.month) {
      newMonthList.add(date);
    } else {
      finalList.add(newMonthList);
      newMonthList = [];
      lastMonth = date.month;
      newMonthList.add(date);
    }
  }
  if (newMonthList.isNotEmpty) finalList.add(newMonthList);
  return finalList;
}

bool isSameDay(DateTime a, DateTime? b) =>
    a.year == b?.year && a.month == b?.month && a.day == b?.day;

DateTime getNowWithoutTime() {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
}

DateTime addToDate(DateTime? date, int type, int intervall) {
  DateTime startDate = date ?? getNowWithoutTime();
  switch (type) {
    case 0:
      return startDate.add(Duration(days: intervall));
    case 1:
      return startDate.add(Duration(days: intervall * 7));
    case 2:
      return DateTime(
        startDate.year,
        startDate.month + intervall,
        startDate.day,
      );
    case 3:
      return DateTime(
        startDate.year + intervall,
        startDate.month,
        startDate.day,
      );
    default:
      return getNowWithoutTime();
  }
}
