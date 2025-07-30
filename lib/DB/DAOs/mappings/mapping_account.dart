import 'package:flutter/material.dart';
import 'package:scrubbit/DB/DAOs/dao_task.dart';
import 'package:scrubbit/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/DB/SQLite/Tables/t_account.dart';

class MappingAccount {
  final DaoTask daoTask;
  MappingAccount(this.daoTask);

  Future<DsAccount> fromMap(Map<String, dynamic> rawData) async {
    final ownedTasks = await daoTask.getTaskOwned(rawData[TAccount.id]);
    final doneTasks = await daoTask.getDoneBy(rawData[TAccount.id]);

    return DsAccount(
      id: rawData[TAccount.id],
      name: rawData[TAccount.name],
      color: Color(rawData[TAccount.color]),
      icon: IconData(
        rawData[TAccount.iconCode],
        fontFamily: rawData[TAccount.iconFamily],
      ),
      ownedTasks: ownedTasks.isNotEmpty ? ownedTasks : null,
      doneTasks: doneTasks.isNotEmpty ? doneTasks : null,
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
      TAccount.iconCode: account.icon.codePoint,
      TAccount.iconFamily: account.icon.fontFamily,
    };
  }
}
