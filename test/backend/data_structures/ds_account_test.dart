import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';

void main() {
  test('constructor sets default values and generates id', () {
    final account = DsAccount(name: 'Alice', color: Colors.blue, score: 5);
    expect(account.id, isNotEmpty);
    expect(account.name, 'Alice');
    expect(account.color, Colors.blue);
    expect(account.score, 5);
  });

  test('update mutates fields and marks instance as dirty', () {
    final account = DsAccount(name: 'Bob', color: Colors.green, score: 1, fromDB: true);
    account.update(newName: 'Robert', newColor: Colors.red, newScore: 10);

    expect(account.name, 'Robert');
    expect(account.color, Colors.red);
    expect(account.score, 10);
    expect(account.fromDB, isFalse);
  });

  test('updateComplete copies values from another account with same id', () {
    final original = DsAccount(name: 'Carol', color: Colors.purple, score: 2);
    final updated = DsAccount(
      id: original.id,
      name: 'Caroline',
      color: Colors.orange,
      score: 8,
      fromDB: true,
    );

    original.updateComplete(updated);
    expect(original.name, 'Caroline');
    expect(original.color, Colors.orange);
    expect(original.score, 8);
    expect(original.fromDB, isFalse);
  });

  test('copyWith keeps original id but allows overriding fields', () {
    final account = DsAccount(name: 'Dave', color: Colors.black, score: 4);
    final copy = account.copyWith(newName: 'David', newColor: Colors.white, newScore: 7);

    expect(copy.id, account.id);
    expect(copy.name, 'David');
    expect(copy.color, Colors.white);
    expect(copy.score, 7);
    expect(account.name, 'Dave');
    expect(account.color, Colors.black);
    expect(account.score, 4);
  });
}
