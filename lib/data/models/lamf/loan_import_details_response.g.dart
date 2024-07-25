// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_import_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanImportDetailsModel _$LoanImportDetailsModelFromJson(
        Map<String, dynamic> json) =>
    LoanImportDetailsModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dob: json['dob'] as String?,
      mobile: json['mobile'] as String?,
      pan: json['pan'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$LoanImportDetailsModelToJson(
        LoanImportDetailsModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dob': instance.dob,
      'mobile': instance.mobile,
      'pan': instance.pan,
      'email': instance.email,
    };
