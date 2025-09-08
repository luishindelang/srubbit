import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';

class UiAccount extends ChangeNotifier {
  final _accounts = <DsAccount>[];

  bool _isLoaded = false;

  UnmodifiableListView<DsAccount> get accounts =>
      UnmodifiableListView(_accounts);

  void _updateList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      final index = _accounts.indexWhere((old) => old.id == account.id);
      if (index != -1) {
        _accounts[index].updateComplete(account);
        dbService.daoAccounts.update(account);
      }
    }
  }

  void _addList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      _accounts.add(account);
      dbService.daoAccounts.insert(account);
    }
  }

  void _removeList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      _accounts.removeWhere((old) => old.id == account.id);
      dbService.daoAccounts.delete(account.id);
    }
  }

  void finishEditAccounts(
    List<DsAccount> add,
    List<DsAccount> update,
    List<DsAccount> remove,
  ) {
    _addList(add);
    _updateList(update);
    _removeList(remove);
    notifyListeners();
  }

  void loadAccounts() async {
    if (!_isLoaded) {
      final dbService = await DatabaseService.init();
      final data = await dbService.daoAccounts.getAll();
      for (var account in data) {
        _accounts.add(account);
      }
      _isLoaded = true;
      notifyListeners();
    }
  }
}
