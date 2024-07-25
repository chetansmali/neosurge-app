// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bank_mandate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBankMandateModel _$UserBankMandateModelFromJson(
        Map<String, dynamic> json) =>
    UserBankMandateModel(
      mandateId: json['mandateID'] as int,
      status: json['status'] as String,
      createdOn: json['createdOn'] as String,
    );

Map<String, dynamic> _$UserBankMandateModelToJson(
        UserBankMandateModel instance) =>
    <String, dynamic>{
      'mandateID': instance.mandateId,
      'status': instance.status,
      'createdOn': instance.createdOn,
    };
