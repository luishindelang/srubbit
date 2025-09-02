import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Service/s_app_data.dart';

class UiAccount extends ChangeNotifier {
  final _accounts = SAppData.instance.accounts;

  UnmodifiableListView<DsAccount> get accounts =>
      UnmodifiableListView(_accounts);

  void add(DsAccount account) {
    _accounts.add(account);
    notifyListeners();
  }

  void remove(DsAccount account) {
    _accounts.remove(account);
    notifyListeners();
  }

  void update(DsAccount account) {
    remove(account);
    add(account);
    notifyListeners();
  }
}
