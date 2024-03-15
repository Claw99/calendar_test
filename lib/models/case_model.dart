// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaseModel {
  final String beginingDay;
  String? beginingTime;
  final String caseName;
  String? image;

  CaseModel(
      {required this.beginingDay,
      this.beginingTime,
      this.image,
      required this.caseName});
}
