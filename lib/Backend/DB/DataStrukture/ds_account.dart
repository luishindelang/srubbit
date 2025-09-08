import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsAccount {
  late String _id;
  late String _name;
  late Color _color;

  bool fromDB;

  DsAccount({
    String? id,
    required String name,
    required Color color,
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _name = name;
    _color = color;
  }

  String get id => _id;
  String get name => _name;
  Color get color => _color;

  void update({
    String? newName,
    Color? newColor,
    IconData? newIcon,
    int? newScore,
  }) {
    _name = newName ?? _name;
    _color = newColor ?? _color;
    fromDB = false;
  }

  void updateComplete(DsAccount account) {
    if (_id == account.id) {
      _name = account.name;
      _color = account.color;
      fromDB = false;
    }
  }

  DsAccount copyWith({String? newName, Color? newColor}) {
    return DsAccount(
      id: _id,
      name: newName ?? _name,
      color: newColor ?? _color,
    );
  }
}
