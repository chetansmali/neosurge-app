// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_nominee_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycNomineeDetailsModel _$GetKycNomineeDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetKycNomineeDetailsModel(
      id: json['id'] as int,
      nomineeFullName: json['nomineeFullName'] as String,
      nomineeDateOfBirth: DateTime.parse(json['nomineeDateOfBirth'] as String),
      nomineeRelationType: DropDownItem.fromJson(
          json['nomineeRelationType'] as Map<String, dynamic>),
      allocationPercentage: (json['allocationPercentage'] as num).toDouble(),
      guardianName: json['guardianName'] as String?,
      guardianRelationship: json['guardianRelationship'] == null
          ? null
          : DropDownItem.fromJson(
              json['guardianRelationship'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetKycNomineeDetailsModelToJson(
        GetKycNomineeDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nomineeFullName': instance.nomineeFullName,
      'nomineeDateOfBirth': instance.nomineeDateOfBirth.toIso8601String(),
      'nomineeRelationType': instance.nomineeRelationType,
      'allocationPercentage': instance.allocationPercentage,
      'guardianName': instance.guardianName,
      'guardianRelationship': instance.guardianRelationship,
    };
