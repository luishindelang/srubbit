import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsAccount {
  late String _id;
  late String _name;
  late Color _color;
  late int _score;

  bool fromDB;

  DsAccount({
    String? id,
    required String name,
    required Color color,
    int score = 0,
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _name = name;
    _color = color;
    _score = score;
  }

  String get id => _id;
  String get name => _name;
  Color get color => _color;
  int get score => _score;

  void update({
    String? newName,
    Color? newColor,
    IconData? newIcon,
    int? newScore,
  }) {
    _name = newName ?? _name;
    _color = newColor ?? _color;
    _score = newScore ?? _score;
    fromDB = false;
  }

  void updateComplete(DsAccount account) {
    if (_id == account.id) {
      _name = account.name;
      _color = account.color;
      _score = account.score;
      fromDB = false;
    }
  }

  DsAccount copyWith({String? newName, Color? newColor, int? newScore}) {
    return DsAccount(
      id: _id,
      name: newName ?? _name,
      color: newColor ?? _color,
      score: newScore ?? _score,
    );
  }
}
