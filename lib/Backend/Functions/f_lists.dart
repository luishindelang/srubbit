List<T> rotate<T>(List<T> list, int start) {
  final n = list.length;
  final s = ((start % n) + n) % n;
  return [...list.sublist(s), ...list.sublist(0, s)];
}

List<T> timeSpann<T>(List<T> list, int from, int to) {
  if (from > to) {
    return [...list.sublist(from), ...list.sublist(0, to + 1)];
  } else {
    return [...list.sublist(from, to + 1)];
  }
}

List<DateTime> dateTimeSpann(DateTime from, DateTime to) {
  DateTime current = from;
  DateTime second = to;
  if (from.isAfter(to)) {
    current = to;
    second = from;
  }
  List<DateTime> dates = [];

  while (!current.isAfter(second)) {
    dates.add(current);
    current = current.add(const Duration(days: 1));
  }

  return dates;
}
