class DsTaskDate {
  final String id;
  final DateTime plannedDate;
  final int completionWindow;

  final bool fromDB;

  const DsTaskDate({
    required this.id,
    required this.plannedDate,
    required this.completionWindow,
    this.fromDB = false,
  });

  DsTaskDate copyWith({DateTime? newPlannedDate, int? newCompletionWindow}) {
    return DsTaskDate(
      id: id,
      plannedDate: newPlannedDate ?? plannedDate,
      completionWindow: newCompletionWindow ?? completionWindow,
    );
  }
}
