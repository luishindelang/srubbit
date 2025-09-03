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
  }

  String get id => _id;
  int get repeatingType => _repeatingType;
  int get repeatingIntervall => _repeatingIntervall;
  int? get repeatingCount => _repeatingCount;
  bool get repeatAfterDone => _repeatAfterDone;
  DateTime get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateTime? get lastDoneDate => _lastDoneDate;

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

  bool isToday() {
    var today = getNowWithoutTime();
    if (_repeatingCount != null && _repeatingCount == 0) return false;
    switch (_repeatingType) {
      case 0:
        if (_lastDoneDate == null) {
          if (isSameDay(today, _startDate)) return true;
          return false;
        } else {
          int diff = 0;
          if (!_repeatAfterDone) {
            diff = today.difference(_startDate).inDays;
          } else {
            diff = today.difference(_lastDoneDate!).inDays;
          }
          if (diff % _repeatingIntervall == 0) {
            return true;
          }
          return false;
        }
      case 1:
        if (_lastDoneDate == null) {}
        return false;
      default:
        return false;
    }
  }
}
