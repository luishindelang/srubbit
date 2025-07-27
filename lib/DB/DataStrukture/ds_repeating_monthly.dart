class DsRepeatingMonthly {
  final String repeatingTemplateId;
  final int dayOfMonth;

  const DsRepeatingMonthly({
    required this.repeatingTemplateId,
    required this.dayOfMonth,
  });

  DsRepeatingMonthly copyWith({int? newDayOfMonth}) {
    return DsRepeatingMonthly(
      repeatingTemplateId: repeatingTemplateId,
      dayOfMonth: newDayOfMonth ?? dayOfMonth,
    );
  }
}
