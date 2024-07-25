// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_swp_installment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSwpInstallmentParams _$GetSwpInstallmentParamsFromJson(
        Map<String, dynamic> json) =>
    GetSwpInstallmentParams(
      userId: json['userId'] as int,
      swpId: json['mf_redemption_plan'] as String,
    );

Map<String, dynamic> _$GetSwpInstallmentParamsToJson(
        GetSwpInstallmentParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'mf_redemption_plan': instance.swpId,
    };
