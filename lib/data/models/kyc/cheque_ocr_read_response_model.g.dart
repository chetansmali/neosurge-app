// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheque_ocr_read_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChequeOcrReadResponseModel _$ChequeOcrReadResponseModelFromJson(
        Map<String, dynamic> json) =>
    ChequeOcrReadResponseModel(
      accountNumber: json['accountNumber'] as String,
      ifscCode: json['ifscCode'] as String,
      chequeNumber: json['chequeNumber'] as String,
      micrCode: json['micrCode'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$ChequeOcrReadResponseModelToJson(
        ChequeOcrReadResponseModel instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'ifscCode': instance.ifscCode,
      'chequeNumber': instance.chequeNumber,
      'micrCode': instance.micrCode,
      'status': instance.status,
    };
