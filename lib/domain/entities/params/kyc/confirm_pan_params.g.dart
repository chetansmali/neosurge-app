// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_pan_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmPanParams _$ConfirmPanParamsFromJson(Map<String, dynamic> json) =>
    ConfirmPanParams(
      panNumber: json['panNumber'] as String,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      isCompliant: json['isCompliant'] as bool,
    );

Map<String, dynamic> _$ConfirmPanParamsToJson(ConfirmPanParams instance) =>
    <String, dynamic>{
      'panNumber': instance.panNumber,
      'fullName': instance.fullName,
      'dateOfBirth': instance.dateOfBirth,
      'isCompliant': instance.isCompliant,
    };
