// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_loan_import_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInitiateLoanImportsParams _$GetInitiateLoanImportsParamsFromJson(
        Map<String, dynamic> json) =>
    GetInitiateLoanImportsParams(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      dob: json['dob'] as String,
      mobile: json['mobile'] as String,
      pan: json['pan'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$GetInitiateLoanImportsParamsToJson(
        GetInitiateLoanImportsParams instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dob': instance.dob,
      'mobile': instance.mobile,
      'pan': instance.pan,
      'email': instance.email,
    };
