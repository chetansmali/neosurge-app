// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_address_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadAddressDetailsParams _$UploadAddressDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    UploadAddressDetailsParams(
      permAddressLine1: json['permAddressLine1'] as String,
      permAddressLine2: json['permAddressLine2'] as String,
      permCity: json['permCity'] as String,
      permPincode: json['permPincode'] as int,
      permState: json['permState'] as int,
      permCountry: json['permCountry'] as int? ?? 101,
      permSameAsCurr: json['permSameAsCurr'] as bool,
      currAddressLine1: json['currAddressLine1'] as String?,
      currAddressLine2: json['currAddressLine2'] as String?,
      currCity: json['currCity'] as String?,
      currPincode: json['currPincode'] as int?,
      currState: json['currState'] as int?,
      currCountry: json['currCountry'] as int? ?? 101,
    );

Map<String, dynamic> _$UploadAddressDetailsParamsToJson(
        UploadAddressDetailsParams instance) =>
    <String, dynamic>{
      'permAddressLine1': instance.permAddressLine1,
      'permAddressLine2': instance.permAddressLine2,
      'permCity': instance.permCity,
      'permPincode': instance.permPincode,
      'permState': instance.permState,
      'permCountry': instance.permCountry,
      'permSameAsCurr': instance.permSameAsCurr,
      'currAddressLine1': instance.currAddressLine1,
      'currAddressLine2': instance.currAddressLine2,
      'currCity': instance.currCity,
      'currPincode': instance.currPincode,
      'currState': instance.currState,
      'currCountry': instance.currCountry,
    };
