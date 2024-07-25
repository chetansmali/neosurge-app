// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switchable_mandate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwitchableMandateModel _$SwitchableMandateModelFromJson(
        Map<String, dynamic> json) =>
    SwitchableMandateModel(
      mandateID: json['mandateID'] as int,
      mandateLimit: (json['mandateLimit'] as num).toDouble(),
      bankName: json['bankName'] as String,
    );

Map<String, dynamic> _$SwitchableMandateModelToJson(
        SwitchableMandateModel instance) =>
    <String, dynamic>{
      'mandateID': instance.mandateID,
      'mandateLimit': instance.mandateLimit,
      'bankName': instance.bankName,
    };
