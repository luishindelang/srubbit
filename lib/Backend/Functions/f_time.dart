import 'package:flutter/material.dart';

String formatDate(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

String formatTime(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
