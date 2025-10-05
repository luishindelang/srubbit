import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class UiAccount extends ChangeNotifier {
  final _accounts = <DsAccount>[];

  bool _isLoaded = false;

  UnmodifiableListView<DsAccount> get accounts =>
      UnmodifiableListView(_accounts);

  Future<void> _updateList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      final index = _accounts.indexWhere((old) => old.id == account.id);
      if (index != -1) {
        _accounts[index].updateComplete(account);
        await dbService.daoAccounts.update(account);
      }
    }
  }

  Future<void> _addList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      _accounts.add(account);
      await dbService.daoAccounts.insert(account);
    }
  }

  Future<void> _removeList(List<DsAccount> accounts) async {
    final dbService = await DatabaseService.init();
    for (var account in accounts) {
      _accounts.removeWhere((old) => old.id == account.id);
      await dbService.daoAccounts.delete(account.id);
    }
  }

  void finishEditAccounts(
    List<DsAccount> add,
    List<DsAccount> update,
    List<DsAccount> remove,
    UiHome home,
  ) async {
    await _addList(add);
    await _updateList(update);
    await _removeList(remove);
    home.reloadData();
    notifyListeners();
  }

  void loadAccounts() async {
    if (!_isLoaded) {
      final dbService = await DatabaseService.init();
      final data = await dbService.daoAccounts.getAll();
      _accounts.clear();
      for (var account in data) {
        _accounts.add(account);
      }
      _isLoaded = true;
      notifyListeners();
    }
  }

  void reloadAccounts() async {
    final dbService = await DatabaseService.init();
    final data = await dbService.daoAccounts.getAll();
    _accounts.clear();
    for (var account in data) {
      _accounts.add(account);
    }
    _isLoaded = true;
    notifyListeners();
  }

  void updateScore(List<DsAccount> selectedAccounts) async {
    final dbService = await DatabaseService.init();
    if (selectedAccounts.isEmpty) {
      for (var account in _accounts) {
        account.update(newScore: account.score + 1);
        await dbService.daoAccounts.update(account);
      }
    } else {
      for (var account in selectedAccounts) {
        account.update(newScore: account.score + 1);
        dbService.daoAccounts.update(account);
      }
    }
    notifyListeners();
  }

  void onDeleteTaskDate() {
    notifyListeners();
  }
}
