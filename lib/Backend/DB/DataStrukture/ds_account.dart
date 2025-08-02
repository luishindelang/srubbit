import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsAccount {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  final bool fromDB;

  DsAccount({
    String? id,
    required this.name,
    required this.color,
    required this.icon,
    this.fromDB = false,
  }) : id = id ?? uuid();

  DsAccount copyWith({String? newName, Color? newColor, IconData? newIcon}) {
    return DsAccount(
      id: id,
      name: newName ?? name,
      color: newColor ?? color,
      icon: newIcon ?? icon,
    );
  }
}
