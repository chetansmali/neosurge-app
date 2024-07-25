// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mandate_sip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MandateSipModel _$MandateSipModelFromJson(Map<String, dynamic> json) =>
    MandateSipModel(
      planName: json['planName'] as String,
      planLogo: json['planLogo'] as String?,
      amount: (json['amount'] as num).toDouble(),
      installmentDay: json['installmentDay'] as String,
      sipId: json['sipId'] as int,
    );

Map<String, dynamic> _$MandateSipModelToJson(MandateSipModel instance) =>
    <String, dynamic>{
      'planName': instance.planName,
      'planLogo': instance.planLogo,
      'amount': instance.amount,
      'installmentDay': instance.installmentDay,
      'sipId': instance.sipId,
    };
