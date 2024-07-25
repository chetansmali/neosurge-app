// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_delivery_address_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddDeliveryAddressParams _$AddDeliveryAddressParamsFromJson(
        Map<String, dynamic> json) =>
    AddDeliveryAddressParams(
      address: json['address'] as String,
      pincode: json['pincode'] as String,
      cityId: json['cityId'] as String,
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNumber'] as String,
    );

Map<String, dynamic> _$AddDeliveryAddressParamsToJson(
        AddDeliveryAddressParams instance) =>
    <String, dynamic>{
      'address': instance.address,
      'pincode': instance.pincode,
      'cityId': instance.cityId,
      'fullName': instance.fullName,
      'mobileNumber': instance.mobileNumber,
    };
