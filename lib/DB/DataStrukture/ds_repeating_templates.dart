class DsRepeatingTemplates {
  final String id;
  final String repeatingType;
  final int repeatingAmount;
  final DateTime startDateInt;
  final DateTime? endDateInt;

  const DsRepeatingTemplates({
    required this.id,
    required this.repeatingType,
    required this.repeatingAmount,
    required this.startDateInt,
    this.endDateInt,
  });

  DsRepeatingTemplates copyWith({
    String? newRepeatingType,
    int? newRepeatingAmount,
    DateTime? newStartDate,
    DateTime? newEndDate,
  }) {
    return DsRepeatingTemplates(
      id: id,
      repeatingType: newRepeatingType ?? repeatingType,
      repeatingAmount: newRepeatingAmount ?? repeatingAmount,
      startDateInt: newStartDate ?? startDateInt,
      endDateInt: newEndDate ?? endDateInt,
    );
  }
}
