class DayCellModel {
  final DateTime day;
  final double eventsCounter;
  bool? isOccupied;

  DayCellModel(
      {required this.day,
      required this.eventsCounter,
      this.isOccupied = false});

  DayCellModel copyWith({
    DateTime? day,
    double? eventsCounter,
    bool? isOccupied,
  }) {
    return DayCellModel(
      day: day ?? this.day,
      eventsCounter: eventsCounter ?? this.eventsCounter,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }
}
