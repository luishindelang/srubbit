class DsRepeatingTemplates<T> {
  final String id;
  final String repeatingType;
  final T repeatingData;
  final DateTime startDateInt;
  final DateTime? endDateInt;

  const DsRepeatingTemplates({
    required this.id,
    required this.repeatingType,
    required this.repeatingData,
    required this.startDateInt,
    this.endDateInt,
  });

  DsRepeatingTemplates copyWith({
    String? newRepeatingType,
    T? newRepeatingData,
    DateTime? newStartDate,
    DateTime? newEndDate,
  }) {
    return DsRepeatingTemplates(
      id: id,
      repeatingType: newRepeatingType ?? repeatingType,
      repeatingData: newRepeatingData ?? repeatingData,
      startDateInt: newStartDate ?? startDateInt,
      endDateInt: newEndDate ?? endDateInt,
    );
  }
}
