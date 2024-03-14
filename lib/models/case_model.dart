// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaseModel {
  final DateTime beginingDay;
  String? beginingTime;
  final String caseName;
  String? image;

  CaseModel(
      {required this.beginingDay,
      this.beginingTime,
      this.image,
      required this.caseName});

  CaseModel copyWith({
    DateTime? beginingTime,
    String? endingTime,
    String? caseName,
  }) {
    return CaseModel(
        beginingDay: beginingTime ?? this.beginingDay,
        beginingTime: endingTime ?? this.beginingTime,
        image: image ?? this.image,
        caseName: caseName ?? this.caseName);
  }
}
