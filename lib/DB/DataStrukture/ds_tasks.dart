import 'package:scrubbit/DB/SQLite/Tables/t_tasks.dart';

class DsTasks {
  final String id;
  final String name;
  final int plannedDateInt;
  final int completionWindowDays;
  final int? timeFromInt;
  final int? timeUntilInt;
  final int? doneDateInt;
  final String? doneBy;
  final String? templateId;

  const DsTasks({
    required this.id,
    required this.name,
    required this.plannedDateInt,
    required this.completionWindowDays,
    this.timeFromInt,
    this.timeUntilInt,
    this.doneDateInt,
    this.doneBy,
    this.templateId,
  });

  factory DsTasks.fromMap(Map<String, dynamic> map) {
    int? toIntOrNull(dynamic value) => value is int ? value : null;
    String? toStringOrNull(dynamic value) => value is String ? value : null;

    return DsTasks(
      id: map[TTasks.id] as String,
      name: map[TTasks.name] as String,
      plannedDateInt: map[TTasks.plannedDate] as int,
      completionWindowDays: map[TTasks.completionWindowDays] as int,
      timeFromInt: toIntOrNull(map[TTasks.timeFrom]),
      timeUntilInt: toIntOrNull(map[TTasks.timeUntil]),
      doneDateInt: toIntOrNull(map[TTasks.doneDate]),
      doneBy: toStringOrNull(map[TTasks.doneBy]),
      templateId: toStringOrNull(map[TTasks.templateId]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TTasks.id: id,
      TTasks.name: name,
      TTasks.plannedDate: plannedDateInt,
      TTasks.completionWindowDays: completionWindowDays,
      TTasks.timeFrom: timeFromInt,
      TTasks.timeUntil: timeUntilInt,
      TTasks.doneDate: doneDateInt,
      TTasks.doneBy: doneBy,
      TTasks.templateId: templateId,
    };
  }

  bool get isDone => doneDateInt != null && doneBy != null;

  DateTime get plannedDate =>
      DateTime.fromMillisecondsSinceEpoch(plannedDateInt);
  DateTime? get timeFrom =>
      timeFromInt != null
          ? DateTime.fromMillisecondsSinceEpoch(timeFromInt!)
          : null;
  DateTime? get timeUntil =>
      timeUntilInt != null
          ? DateTime.fromMillisecondsSinceEpoch(timeUntilInt!)
          : null;
  DateTime? get doneDate =>
      doneDateInt != null
          ? DateTime.fromMillisecondsSinceEpoch(doneDateInt!)
          : null;
}
