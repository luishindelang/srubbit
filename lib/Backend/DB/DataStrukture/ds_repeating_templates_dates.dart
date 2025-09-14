import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsRepeatingTemplatesDates {
  late String _id;
  late int _month;
  late int _monthDay;
  late int _weekDay;

  bool fromDB;

  DsRepeatingTemplatesDates({
    String? id,
    int month = 0,
    int monthDay = 0,
    int weekDay = 0,
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _month = month;
    _monthDay = monthDay;
    _weekDay = weekDay;
  }

  String get id => _id;
  int get month => _month;
  int get monthDay => _monthDay;
  int get weekDay => _weekDay;
}
