import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';

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

List<DateTime> datesUntilEndOfWeek() {
  final today = getNowWithoutTime();
  final daysUntilSunday = DateTime.sunday - today.weekday;

  return List.generate(
    daysUntilSunday + 1,
    (i) => today.add(Duration(days: i)),
  );
}

List<DateTime> datesUntilEndOfMonth() {
  final today = getNowWithoutTime();
  final startOfNextMonth =
      (today.month == 12)
          ? DateTime(today.year + 1, 1, 1)
          : DateTime(today.year, today.month + 1, 1);

  final lastDayOfMonth = startOfNextMonth.subtract(const Duration(days: 1));

  final daysUntilEnd = lastDayOfMonth.difference(today).inDays;

  return List.generate(daysUntilEnd + 1, (i) => today.add(Duration(days: i)));
}

bool isSameDay(DateTime? a, DateTime? b) =>
    a?.year == b?.year && a?.month == b?.month && a?.day == b?.day;

bool isToday(DateTime date) {
  final today = getNowWithoutTime();
  return isSameDay(date, today);
}

bool isTomorrow(DateTime date) {
  final tomorrow = getNowWithoutTime().add(Duration(days: 1));
  return isSameDay(date, tomorrow);
}

bool isInCurrentWeek(DateTime date) {
  final today = getNowWithoutTime();
  final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  return !date.isBefore(startOfWeek) && date.isBefore(endOfWeek);
}

bool isInCurrentMonth(DateTime date) {
  final now = getNowWithoutTime();

  return date.year == now.year && date.month == now.month;
}

bool allDaysUntilSundayIncluded(List<DateTime> dates) {
  if (dates.isEmpty) return false;

  final today = getNowWithoutTime();
  final daysUntilSunday = DateTime.sunday - today.weekday;
  final requiredDays =
      List.generate(
        daysUntilSunday + 1,
        (i) => DateTime(today.year, today.month, today.day + i),
      ).toSet();
  final givenDays = dates.map((d) => DateTime(d.year, d.month, d.day)).toSet();
  return requiredDays.every(givenDays.contains);
}

bool allDaysUntilEndOfMonthIncluded(List<DateTime> dates) {
  if (dates.isEmpty) return false;

  final today = getNowWithoutTime();
  final startOfNextMonth =
      (today.month == 12)
          ? DateTime(today.year + 1, 1, 1)
          : DateTime(today.year, today.month + 1, 1);
  final lastDayOfMonth = startOfNextMonth.subtract(const Duration(days: 1));
  final requiredDays =
      List.generate(
        lastDayOfMonth.difference(today).inDays + 1,
        (i) => DateTime(today.year, today.month, today.day + i),
      ).toSet();
  final givenDays = dates.map((d) => DateTime(d.year, d.month, d.day)).toSet();
  return requiredDays.every(givenDays.contains);
}

DateTime getNowWithoutTime({
  int addYear = 0,
  int addMonth = 0,
  int addDay = 0,
}) {
  return DateTime(
    DateTime.now().year + addYear,
    DateTime.now().month + addMonth,
    DateTime.now().day + addDay,
  );
}

int daysUntilEndOfWeek(DateTime date) {
  int weekday = date.weekday;
  int daysLeft = DateTime.daysPerWeek - weekday;
  return daysLeft;
}

int daysUntilEndOfMonth(DateTime date) {
  final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
  return lastDayOfMonth.difference(date).inDays;
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

int adjustDayForMonth(int day, int month, int year) {
  final lastDayOfMonth = DateTime(year, month + 1, 0).day;

  if (day > lastDayOfMonth) {
    return lastDayOfMonth;
  }
  return day;
}

int monthDifference(DateTime from, DateTime to) {
  return (to.year - from.year) * 12 + (to.month - from.month);
}

int yearDifference(DateTime from, DateTime to) {
  return (to.year - from.year);
}
