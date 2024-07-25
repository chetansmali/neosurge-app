// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddressDetailsModel _$DeliveryAddressDetailsModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAddressDetailsModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      emailId: json['emailId'] as String,
      address: json['address'] as String,
      state: DGUserState.fromJson(json['state'] as Map<String, dynamic>),
      city: DGUserCity.fromJson(json['city'] as Map<String, dynamic>),
      pincode: json['pincode'] as String,
      userAddressId: json['userAddressId'] as String,
      userAccountId: json['userAccountId'] as String,
      isDelivered: json['isDelivered'] as bool,
    );

Map<String, dynamic> _$DeliveryAddressDetailsModelToJson(
        DeliveryAddressDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'mobileNumber': instance.mobileNumber,
      'emailId': instance.emailId,
      'address': instance.address,
      'state': instance.state,
      'city': instance.city,
      'pincode': instance.pincode,
      'userAddressId': instance.userAddressId,
      'userAccountId': instance.userAccountId,
      'isDelivered': instance.isDelivered,
    };

DGUserCity _$DGUserCityFromJson(Map<String, dynamic> json) => DGUserCity(
      cityId: json['cityId'] as String,
      name: json['name'] as String,
      state: DGUserState.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DGUserCityToJson(DGUserCity instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'name': instance.name,
      'state': instance.state,
    };

DGUserState _$DGUserStateFromJson(Map<String, dynamic> json) => DGUserState(
      stateId: json['stateId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DGUserStateToJson(DGUserState instance) =>
    <String, dynamic>{
      'stateId': instance.stateId,
      'name': instance.name,
    };
