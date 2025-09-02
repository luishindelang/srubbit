import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsAccount {
  late String _id;
  late String _name;
  late Color _color;
  late IconData _icon;
  late int _score;

  bool fromDB;

  DsAccount({
    String? id,
    required String name,
    required Color color,
    required IconData icon,
    int score = 0,
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _name = name;
    _color = color;
    _icon = icon;
    _score = score;
  }

  String get id => _id;
  String get name => _name;
  Color get color => _color;
  IconData get icon => _icon;
  int get score => _score;

  void update({
    String? newName,
    Color? newColor,
    IconData? newIcon,
    int? newScore,
  }) {
    _name = newName ?? _name;
    _color = newColor ?? _color;
    _icon = newIcon ?? _icon;
    _score = newScore ?? _score;
    fromDB = false;
  }

  void updateComplete(DsAccount account) {
    if (_id == account.id) {
      _name = account.name;
      _color = account.color;
      _icon = account.icon;
      _score = account.score;
      fromDB = false;
    }
  }

  DsAccount copyWith({
    String? newName,
    Color? newColor,
    IconData? newIcon,
    int? newScore,
  }) {
    return DsAccount(
      id: _id,
      name: newName ?? _name,
      color: newColor ?? _color,
      icon: newIcon ?? _icon,
      score: newScore ?? _score,
    );
  }
}
