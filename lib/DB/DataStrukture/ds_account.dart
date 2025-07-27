import 'package:flutter/material.dart';
import 'package:scrubbit/DB/DataStrukture/ds_task.dart';

class DsAccount {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final List<DsTask>? ownedTasks;
  final List<DsTask>? doneTasks;

  final bool fromDB;

  const DsAccount({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    this.ownedTasks,
    this.doneTasks,
    this.fromDB = false,
  });

  DsAccount copyWith({String? newName, Color? newColor, IconData? newIcon}) {
    return DsAccount(
      id: id,
      name: newName ?? name,
      color: newColor ?? color,
      icon: newIcon ?? icon,
    );
  }
}
