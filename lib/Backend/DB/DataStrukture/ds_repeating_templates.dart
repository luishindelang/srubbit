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

  List<DateTime> test() {
    List<DateTime> dates = [];
    final now = getNowWithoutTime();
    if (_lastDoneDate != null) {
      if (_repeatingType == 0) {
        final daysSiceStart = now.difference(_startDate).inDays;
        if (!_repeatAfterDone) {
          final daysToNext = daysSiceStart % _repeatingIntervall;
          return [now.add(Duration(days: daysToNext))];
        } else {
          return [_lastDoneDate!.add(Duration(days: _repeatingIntervall))];
        }
      } else if (_repeatingType == 1) {
        final daysUntilEndOfWeek = 7 - now.weekday;
        final startOfNextWeek = now.add(Duration(days: daysUntilEndOfWeek + 1));
        final nextWeekStartDate = startOfNextWeek.add(
          Duration(days: _repeatingIntervall * 7),
        );
        for (var repeatingDate in _repeatingDates) {
          final weekDay = repeatingDate.weekDay;
          if (weekDay != 0) {
            if (weekDay >= now.weekday) {
              final daysUntil = weekDay - now.weekday;
              dates.add(now.add(Duration(days: daysUntil)));
            } else {
              dates.add(nextWeekStartDate.add(Duration(days: weekDay)));
            }
          }
        }
      } else if (_repeatingType == 2) {}
    } else {
      return [_startDate.add(Duration(days: _repeatingIntervall))];
    }
    return dates;
  }
}
