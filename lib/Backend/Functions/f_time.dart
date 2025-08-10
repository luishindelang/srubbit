import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

String formatDateTime(DateTime dateTime) {
  return "${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";
}

String formatDate(DateTime dateTime, bool withMonth, bool withYear) {
  String month = "";
  String year = "";
  if (withYear) year = " ${dateTime.year}";
  if (withMonth) month = monthNames[dateTime.month - 1];
  return "$month$year";
}

String formatDateDay(DateTime dateTime, bool withMonth, bool withYear) {
  String month = "";
  String year = "";
  if (withYear) year = ".${dateTime.year}";
  if (withMonth) month = ".${dateTime.month}";
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

List<String> getNext7Weekdays() {
  final todayIndex = DateTime.now().weekday - 1;
  return List.generate(7, (i) => weekDays[(todayIndex + i) % 7]);
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
