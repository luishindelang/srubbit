import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates_dates.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Functions/f_uuid.dart';

class DsRepeatingTemplates {
  late String _id;
  late int _repeatingType;
  late int _repeatingIntervall;
  late int? _repeatingCount;
  late bool _repeatAfterDone;
  late DateTime _startDate;
  late DateTime? _endDate;
  late DateTime? _lastDoneDate;
  late List<DsRepeatingTemplatesDates> _repeatingDates;

  bool fromDB;

  DsRepeatingTemplates({
    String? id,
    required int repeatingType,
    required int repeatingIntervall,
    int? repeatingCount,
    required bool repeatAfterDone,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? lastDoneDate,
    List<DsRepeatingTemplatesDates>? repeatingDates,
    this.fromDB = false,
  }) {
    _id = id ?? uuid();
    _repeatingType = repeatingType;
    _repeatingIntervall = repeatingIntervall;
    _repeatingCount = repeatingCount;
    _repeatAfterDone = repeatAfterDone;
    _startDate = startDate;
    _endDate = endDate;
    _lastDoneDate = lastDoneDate;
    _repeatingDates = repeatingDates ?? [];
  }

  String get id => _id;
  int get repeatingType => _repeatingType;
  int get repeatingIntervall => _repeatingIntervall;
  int? get repeatingCount => _repeatingCount;
  bool get repeatAfterDone => _repeatAfterDone;
  DateTime get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateTime? get lastDoneDate => _lastDoneDate;
  List<DsRepeatingTemplatesDates> get repeatingDates => _repeatingDates;

  set setLastDoneDate(DateTime? newLastDoneDate) =>
      _lastDoneDate = newLastDoneDate;

  void update({
    int? newRepeatingType,
    int? newRepeatingIntervall,
    int? newRepeatingCount,
    bool? newRepeatAfterDone,
    DateTime? newStartDate,
    DateTime? newEndDate,
    DateTime? newLastDoneDate,
  }) {
    _repeatingType = newRepeatingType ?? _repeatingType;
    _repeatingIntervall = newRepeatingIntervall ?? _repeatingIntervall;
    _repeatingCount = newRepeatingCount ?? _repeatingCount;
    _repeatAfterDone = newRepeatAfterDone ?? _repeatAfterDone;
    _startDate = newStartDate ?? _startDate;
    _endDate = newEndDate ?? _endDate;
    _lastDoneDate = newLastDoneDate ?? _lastDoneDate;
    fromDB = false;
  }

  void updateComplete(DsRepeatingTemplates repeatingTempleate) {
    _repeatingType = repeatingTempleate._repeatingType;
    _repeatingIntervall = repeatingTempleate._repeatingIntervall;
    _repeatingCount = repeatingTempleate._repeatingCount;
    _repeatAfterDone = repeatingTempleate._repeatAfterDone;
    _startDate = repeatingTempleate._startDate;
    _endDate = repeatingTempleate._endDate;
    _lastDoneDate = repeatingTempleate._lastDoneDate;
    fromDB = false;
  }

  DsRepeatingTemplates copyWith({
    int? newRepeatingType,
    int? newRepeatingIntervall,
    int? newRepeatingCount,
    bool? newRepeatAfterDone,
    DateTime? newStartDate,
    DateTime? newEndDate,
    DateTime? newLastDoneDate,
  }) {
    return DsRepeatingTemplates(
      id: _id,
      repeatingType: newRepeatingType ?? _repeatingType,
      repeatingIntervall: newRepeatingIntervall ?? _repeatingIntervall,
      repeatingCount: newRepeatingCount ?? _repeatingCount,
      repeatAfterDone: newRepeatAfterDone ?? _repeatAfterDone,
      startDate: newStartDate ?? _startDate,
      endDate: newEndDate ?? _endDate,
      lastDoneDate: newLastDoneDate ?? _lastDoneDate,
    );
  }

  List<DateTime> getDates() {
    final today = getNowWithoutTime();

    if (_repeatingType == 0) {
      // daily
      if (today.isAfter(_startDate)) {
        return [_startDate];
      }
      if (!_repeatAfterDone) {
        final daysSiceStart = today.difference(_startDate).inDays;
        final daysToNext = daysSiceStart % _repeatingIntervall;
        final nextDate = today.add(Duration(days: daysToNext));
        final lastDate = nextDate.subtract(Duration(days: _repeatingIntervall));
        final missedTask = <DateTime>[];
        if (_lastDoneDate != null) {
          if (!isSameDay(_lastDoneDate!, lastDate)) {
            missedTask.add(lastDate);
          }
        }
        return [...missedTask, nextDate];
      } else {
        if (_lastDoneDate != null) {
          final nextDate = _lastDoneDate!.add(
            Duration(days: _repeatingIntervall),
          );
          return [nextDate];
        }
        return [_startDate];
      }
    } else {
      // weekly,, monthly, yearly
      if (_repeatingDates.isEmpty) {
        return [_startDate];
      }
      var daysToNext = 0;
      if (_repeatingType == 1) {
        final daysSiceStart = today.difference(_startDate).inDays;
        daysToNext = (daysSiceStart ~/ 7) % _repeatingIntervall;
      } else if (_repeatingIntervall == 2) {
        final daysSiceStart = monthDifference(_startDate, today);
        daysToNext = daysSiceStart % _repeatingIntervall;
      } else if (_repeatingType == 3) {
        final daysSiceStart = yearDifference(_startDate, today);
        daysToNext = daysSiceStart % _repeatingIntervall;
      }

      final list = <DateTime>[];
      if (_lastDoneDate != null) {
        final lastDate = _repeatingDates.last.getDate(
          daysToNext - _repeatingIntervall,
        );
        if (!isSameDay(_lastDoneDate, lastDate)) {
          if (lastDate != null) {
            list.add(lastDate);
          }
        }
      }
      for (var repeatingDate in _repeatingDates) {
        final date = repeatingDate.getDate(daysToNext);
        if (date != null) {
          list.add(date);
        }
      }
      return list;
    }
  }
}
