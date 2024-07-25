import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_personal_details_model.g.dart';

@JsonSerializable()
class GetKycPersonalDetailsModel {
  final String fullName;
  final String dateOfBirth;
  final DropDownItem gender;
  final String fatherName;
  final String motherName;
  final DropDownItem occupationType;
  final DropDownItem maritalStatus;
  final bool isPoliticallyExposedPerson;
  final bool isRelationWithPoliticallyExposedPerson;

  GetKycPersonalDetailsModel(
      {required this.fullName,
      required this.dateOfBirth,
      required this.gender,
      required this.fatherName,
      required this.motherName,
      required this.maritalStatus,
      required this.occupationType,
      required this.isRelationWithPoliticallyExposedPerson,
      required this.isPoliticallyExposedPerson});

  factory GetKycPersonalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycPersonalDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycPersonalDetailsModelToJson(this);
}
