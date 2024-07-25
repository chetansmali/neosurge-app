// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pincode_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinCodeDataModel _$PinCodeDataModelFromJson(Map<String, dynamic> json) =>
    PinCodeDataModel(
      code: json['code'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      stateName: json['state_name'] as String,
      countryAnsiCode: json['country_ansi_code'] as String,
      countryName: json['country_name'] as String,
    );

Map<String, dynamic> _$PinCodeDataModelToJson(PinCodeDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'city': instance.city,
      'district': instance.district,
      'state_name': instance.stateName,
      'country_ansi_code': instance.countryAnsiCode,
      'country_name': instance.countryName,
    };
