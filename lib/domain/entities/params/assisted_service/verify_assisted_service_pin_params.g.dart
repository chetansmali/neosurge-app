// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_assisted_service_pin_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAssistedServicePinParams _$VerifyAssistedServicePinParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyAssistedServicePinParams(
      pin: json['pin'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$VerifyAssistedServicePinParamsToJson(
        VerifyAssistedServicePinParams instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'userId': instance.userId,
    };
