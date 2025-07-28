import 'package:flutter/material.dart';
import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';

class MappingAccount {
  DsAccount fromMap(Map<String, dynamic> rawData) {
    return DsAccount(
      id: rawData[TAccount.id],
      name: rawData[TAccount.name],
      color: Color(rawData[TAccount.color]),
      icon: IconData(
        rawData[TAccount.iconCode],
        fontFamily: rawData[TAccount.iconFamily],
      ),
      fromDB: true,
    );
  }

  List<DsAccount> fromList(List<Map<String, dynamic>> rawData) {
    return rawData.map(fromMap).toList();
  }

  Map<String, dynamic> toMap(DsAccount account) {
    return {
      TAccount.id: account.id,
      TAccount.name: account.name,
      TAccount.color: account.color.value,
      TAccount.iconCode: account.icon.codePoint,
      TAccount.iconFamily: account.icon.fontFamily,
    };
  }
}
