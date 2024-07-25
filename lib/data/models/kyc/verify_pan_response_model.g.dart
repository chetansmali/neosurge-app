// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_pan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPanResponseModel _$VerifyPanResponseModelFromJson(
        Map<String, dynamic> json) =>
    VerifyPanResponseModel(
      fullName: json['fullName'] as String?,
      isCompliant: json['isCompliant'] as bool,
      panNumber: json['panNumber'] as String,
    );

Map<String, dynamic> _$VerifyPanResponseModelToJson(
        VerifyPanResponseModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'isCompliant': instance.isCompliant,
      'panNumber': instance.panNumber,
    };
