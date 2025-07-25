import 'package:flutter/material.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_accounts.dart';

class DsAccount {
  final String id;
  final String name;
  final int colorInt;
  final int iconCode;
  final String iconFamily;

  const DsAccount({
    required this.id,
    required this.name,
    required this.colorInt,
    required this.iconCode,
    required this.iconFamily,
  });

  factory DsAccount.fromMap(Map<String, dynamic> map) {
    return DsAccount(
      id: map[TAccounts.id] as String,
      name: map[TAccounts.name] as String,
      colorInt: map[TAccounts.color] as int,
      iconCode: map[TAccounts.iconCode] as int,
      iconFamily: map[TAccounts.iconFamily] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TAccounts.id: id,
      TAccounts.name: name,
      TAccounts.color: colorInt,
      TAccounts.iconCode: iconCode,
      TAccounts.iconFamily: iconFamily,
    };
  }

  DsAccount copyWith({
    String? id,
    String? name,
    int? colorInt,
    int? iconCode,
    String? iconFamily,
  }) {
    return DsAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      colorInt: colorInt ?? this.colorInt,
      iconCode: iconCode ?? this.iconCode,
      iconFamily: iconFamily ?? this.iconFamily,
    );
  }

  Color get color => Color(colorInt);
  IconData get icon => IconData(iconCode, fontFamily: iconFamily);
}
