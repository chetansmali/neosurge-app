// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_read_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcrReadResponseModel _$OcrReadResponseModelFromJson(
        Map<String, dynamic> json) =>
    OcrReadResponseModel(
      docNum: json['docNum'] as String,
      docType: json['docType'] as String,
      dob: json['dob'] as String,
      fullName: json['fullName'] as String?,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$OcrReadResponseModelToJson(
        OcrReadResponseModel instance) =>
    <String, dynamic>{
      'docNum': instance.docNum,
      'docType': instance.docType,
      'dob': instance.dob,
      'fullName': instance.fullName,
      'status': instance.status,
    };
