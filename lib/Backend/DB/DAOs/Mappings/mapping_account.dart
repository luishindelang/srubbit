import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/SQLite/Tables/t_account.dart';

class MappingAccount {
  Future<DsAccount> fromMap(Map<String, dynamic> rawData) async {
    return DsAccount(
      id: rawData[TAccount.id] as String,
      name: rawData[TAccount.name] as String,
      color: Color(rawData[TAccount.color] as int),
      score: rawData[TAccount.score] as int,
      fromDB: true,
    );
  }

  Future<List<DsAccount>> fromList(List<Map<String, dynamic>> rawData) async {
    List<DsAccount> finalData = [];
    for (var value in rawData) {
      finalData.add(await fromMap(value));
    }
    return finalData;
  }

  Map<String, dynamic> toMap(DsAccount account) {
    return {
      TAccount.id: account.id,
      TAccount.name: account.name,
      TAccount.color: account.color.toARGB32(),
      TAccount.score: account.score,
    };
  }
}
