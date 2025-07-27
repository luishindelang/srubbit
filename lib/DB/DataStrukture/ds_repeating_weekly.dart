class DsRepeatingWeekly {
  final String repeatingTemplateId;
  final int weekday;

  const DsRepeatingWeekly({
    required this.repeatingTemplateId,
    required this.weekday,
  });

  DsRepeatingWeekly copyWith({int? newWeekday}) {
    return DsRepeatingWeekly(
      repeatingTemplateId: repeatingTemplateId,
      weekday: newWeekday ?? weekday,
    );
  }
}
