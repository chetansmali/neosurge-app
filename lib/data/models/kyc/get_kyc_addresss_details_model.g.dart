// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_addresss_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycAddressDetailsModel _$GetKycAddressDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetKycAddressDetailsModel(
      permAddressLine1: json['permAddressLine1'] as String,
      permAddressLine2: json['permAddressLine2'] as String,
      permCity: json['permCity'] as String,
      permPincode: json['permPincode'] as int,
      permState:
          DropDownItem.fromJson(json['permState'] as Map<String, dynamic>),
      permCountry:
          DropDownItem.fromJson(json['permCountry'] as Map<String, dynamic>),
      permSameAsCurr: json['permSameAsCurr'] as bool,
      currAddressLine1: json['currAddressLine1'] as String?,
      currAddressLine2: json['currAddressLine2'] as String?,
      currCity: json['currCity'] as String?,
      currPincode: json['currPincode'] as int?,
      currState: json['currState'] == null
          ? null
          : DropDownItem.fromJson(json['currState'] as Map<String, dynamic>),
      currCountry: json['currCountry'] == null
          ? null
          : DropDownItem.fromJson(json['currCountry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetKycAddressDetailsModelToJson(
        GetKycAddressDetailsModel instance) =>
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
