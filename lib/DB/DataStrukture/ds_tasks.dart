import 'package:scrubbit/DB/SQLite/Tables/t_tasks.dart';

class DsTasks {
  final String id;
  final String name;
  final int plannedDateInt;
  final int completionWindowDays;
  final int offset;
  final int? timeFromInt;
  final int? timeUntilInt;
  final String? repeatingTemplateId;

  const DsTasks({
    required this.id,
    required this.name,
    required this.plannedDateInt,
    this.completionWindowDays = 0,
    this.offset = 0,
    this.timeFromInt,
    this.timeUntilInt,
    this.repeatingTemplateId,
  });

  factory DsTasks.fromMap(Map<String, dynamic> map) {
    int? toIntOrNull(dynamic value) => value is int ? value : null;
    String? toStringOrNull(dynamic value) => value is String ? value : null;

    return DsTasks(
      id: map[TTasks.id] as String,
      name: map[TTasks.name] as String,
      plannedDateInt: map[TTasks.plannedDate] as int,
      completionWindowDays: map[TTasks.completionWindowDays] as int,
      offset: map[TTasks.offset] as int,
      timeFromInt: toIntOrNull(map[TTasks.timeFrom]),
      timeUntilInt: toIntOrNull(map[TTasks.timeUntil]),
      repeatingTemplateId: toStringOrNull(map[TTasks.repeatingTemplateId]),
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
      TTasks.repeatingTemplateId: repeatingTemplateId,
    };
  }

  bool get isDone => repeatingTemplateId != null;

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
}
