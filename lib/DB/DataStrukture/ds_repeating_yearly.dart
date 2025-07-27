class DsRepeatingYearly {
  final String repeatingTemplateId;
  final int month;
  final int day;

  const DsRepeatingYearly({
    required this.repeatingTemplateId,
    required this.month,
    required this.day,
  });

  DsRepeatingYearly copyWith({int? newMonth, int? newDay}) {
    return DsRepeatingYearly(
      repeatingTemplateId: repeatingTemplateId,
      month: newMonth ?? month,
      day: newDay ?? day,
    );
  }
}
