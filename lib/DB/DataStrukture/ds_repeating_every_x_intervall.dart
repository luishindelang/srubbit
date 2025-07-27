class DsRepeatingEveryXInterall {
  final String repeatingTemplateId;
  final String intervalUnit;
  final int intervalAmount;

  const DsRepeatingEveryXInterall({
    required this.repeatingTemplateId,
    required this.intervalUnit,
    required this.intervalAmount,
  });

  DsRepeatingEveryXInterall copyWith({
    String? newIntervalUnit,
    int? newIntervalAmount,
  }) {
    return DsRepeatingEveryXInterall(
      repeatingTemplateId: repeatingTemplateId,
      intervalUnit: newIntervalUnit ?? intervalUnit,
      intervalAmount: newIntervalAmount ?? intervalAmount,
    );
  }
}
