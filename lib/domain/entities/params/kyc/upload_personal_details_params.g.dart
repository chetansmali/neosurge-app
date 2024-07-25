// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_personal_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadPersonalDetailsParams _$UploadPersonalDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    UploadPersonalDetailsParams(
      fatherName: json['fatherName'] as String,
      motherName: json['motherName'] as String,
      maritalStatusId: json['maritalStatusId'] as int,
      kycRelationTypeId: json['kycRelationTypeId'] as int,
      occupationId: json['occupationId'] as int,
      gender: $enumDecode(_$GenderEnumMap, json['genderTypeId']),
      countryId: json['countryId'] as int? ?? 101,
      politicalExposure: json['politicalExposure'] as bool? ?? false,
      isRelationWithPoliticallyExposedPerson:
          json['isRelationWithPoliticallyExposedPerson'] as bool? ?? false,
    );

Map<String, dynamic> _$UploadPersonalDetailsParamsToJson(
        UploadPersonalDetailsParams instance) =>
    <String, dynamic>{
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'kycRelationTypeId': instance.kycRelationTypeId,
      'maritalStatusId': instance.maritalStatusId,
      'politicalExposure': instance.politicalExposure,
      'isRelationWithPoliticallyExposedPerson':
          instance.isRelationWithPoliticallyExposedPerson,
      'countryId': instance.countryId,
      'occupationId': instance.occupationId,
      'genderTypeId': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.male: 1,
  Gender.female: 2,
  Gender.transgender: 3,
};
