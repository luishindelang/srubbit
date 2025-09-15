import 'package:scrubbit/Backend/Functions/f_time.dart';
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

  DateTime? getDate(int offset) {
    final today = getNowWithoutTime();

    if (_month != 0 && _monthDay != 0) {
      // yearly
      final targetYear = today.year + offset;
      final day = adjustDayForMonth(_monthDay, _month, targetYear);
      return DateTime(targetYear, _month, day);
    } else if (_monthDay != 0) {
      // montly
      final base = DateTime(today.year, today.month + offset, 1);
      final day = adjustDayForMonth(_monthDay, base.month, base.year);
      return DateTime(base.year, base.month, day);
    } else if (_weekDay != 0) {
      // weekly
      final delta = (_weekDay - today.weekday + 7) % 7;
      final anchor = today.add(Duration(days: delta));
      return anchor.add(Duration(days: 7 * offset));
    }
    return null;
  }
}
