import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/test_data.dart';

void main() {
  test('createAccounts generates requested number of accounts', () {
    final accounts = createAccounts(3);
    expect(accounts.length, 3);
    expect(accounts, everyElement(isA<DsAccount>()));
    expect(accounts.map((a) => a.id).toSet().length, accounts.length);
  });

  test('createAccount returns a single account instance', () {
    final account = createAccount();
    expect(account, isA<DsAccount>());
    expect(account.name, 'name');
  });

  test('createTasks currently returns empty list placeholder', () {
    expect(createTasks(5), isEmpty);
  });
}
