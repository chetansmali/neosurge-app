// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_personal_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycPersonalDetailsModel _$GetKycPersonalDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetKycPersonalDetailsModel(
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: DropDownItem.fromJson(json['gender'] as Map<String, dynamic>),
      fatherName: json['fatherName'] as String,
      motherName: json['motherName'] as String,
      maritalStatus:
          DropDownItem.fromJson(json['maritalStatus'] as Map<String, dynamic>),
      occupationType:
          DropDownItem.fromJson(json['occupationType'] as Map<String, dynamic>),
      isRelationWithPoliticallyExposedPerson:
          json['isRelationWithPoliticallyExposedPerson'] as bool,
      isPoliticallyExposedPerson: json['isPoliticallyExposedPerson'] as bool,
    );

Map<String, dynamic> _$GetKycPersonalDetailsModelToJson(
        GetKycPersonalDetailsModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'occupationType': instance.occupationType,
      'maritalStatus': instance.maritalStatus,
      'isPoliticallyExposedPerson': instance.isPoliticallyExposedPerson,
      'isRelationWithPoliticallyExposedPerson':
          instance.isRelationWithPoliticallyExposedPerson,
    };
