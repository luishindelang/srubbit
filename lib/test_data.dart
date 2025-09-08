import 'dart:math';

import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';

List<DsAccount> createAccounts(int amount) {
  List<DsAccount> accounts = [];
  for (var i = 0; i < amount; i++) {
    final random = Random().nextInt(userColors.length);
    accounts.add(DsAccount(name: "name $i", color: userColors[random]));
  }
  return accounts;
}

DsAccount createAccount() {
  final random = Random().nextInt(userColors.length);
  return DsAccount(name: "name", color: userColors[random]);
}

List<DsTask> createTasks(int amount) {
  List<DsTask> tasks = [];
  for (var i = 0; i < amount; i++) {}
  return tasks;
}
