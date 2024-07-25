import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'upload_personal_details_params.g.dart';

@JsonSerializable()
class UploadPersonalDetailsParams {
  final String fatherName;
  final String motherName;
  final int kycRelationTypeId;
  final int maritalStatusId;
  final bool politicalExposure;
  final bool isRelationWithPoliticallyExposedPerson;
  final int countryId; //Default India
  final int occupationId;
  @JsonKey(name: 'genderTypeId')
  final Gender gender;

  UploadPersonalDetailsParams({
    required this.fatherName,
    required this.motherName,
    required this.maritalStatusId,
    required this.kycRelationTypeId,
    required this.occupationId,
    required this.gender,
    this.countryId = 101,
    this.politicalExposure = false,
    this.isRelationWithPoliticallyExposedPerson = false,
  });

  factory UploadPersonalDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$UploadPersonalDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPersonalDetailsParamsToJson(this);
}
