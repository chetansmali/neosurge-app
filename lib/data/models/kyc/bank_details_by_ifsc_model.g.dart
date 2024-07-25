// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_by_ifsc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailsByIfscModel _$BankDetailsByIfscModelFromJson(
        Map<String, dynamic> json) =>
    BankDetailsByIfscModel(
      ifscCode: json['ifsc_code'] as String,
      micrCode: json['micr_code'] as String?,
      branchName: json['branch_name'] as String,
      branchAddress: json['branch_address'] as String,
      bankName: json['bank_name'] as String,
      contact: json['contact'] as String?,
      city: json['city'] as String,
      district: json['district'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$BankDetailsByIfscModelToJson(
        BankDetailsByIfscModel instance) =>
    <String, dynamic>{
      'ifsc_code': instance.ifscCode,
      'micr_code': instance.micrCode,
      'branch_name': instance.branchName,
      'branch_address': instance.branchAddress,
      'bank_name': instance.bankName,
      'contact': instance.contact,
      'city': instance.city,
      'district': instance.district,
      'state': instance.state,
    };
