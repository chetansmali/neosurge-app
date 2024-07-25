// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'systematic_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystematicPlan _$SystematicPlanFromJson(Map<String, dynamic> json) =>
    SystematicPlan(
      id: json['id'] as int,
      orderId: json['orderId'] as String?,
      orderType: $enumDecode(_$MFTransactionTypesEnumMap, json['orderType']),
      amount: (json['amount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: $enumDecode(_$SystematicPlansStatusEnumMap, json['status']),
      plan: json['plan'] as String,
      planIn: json['planIn'] as String?,
      imgUrl: json['imgUrl'] as String,
      nextInstallmentDate:
          DateTime.parse(json['nextInstallmentDate'] as String),
    );

Map<String, dynamic> _$SystematicPlanToJson(SystematicPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'orderType': _$MFTransactionTypesEnumMap[instance.orderType]!,
      'amount': instance.amount,
      'startDate': instance.startDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': _$SystematicPlansStatusEnumMap[instance.status]!,
      'plan': instance.plan,
      'planIn': instance.planIn,
      'imgUrl': instance.imgUrl,
      'nextInstallmentDate': instance.nextInstallmentDate.toIso8601String(),
    };

const _$MFTransactionTypesEnumMap = {
  MFTransactionTypes.lumpsum: 1,
  MFTransactionTypes.sip: 2,
  MFTransactionTypes.redemption: 3,
  MFTransactionTypes.switchTransaction: 4,
  MFTransactionTypes.stp: 5,
  MFTransactionTypes.swp: 6,
  MFTransactionTypes.stopSip: 7,
  MFTransactionTypes.stopSwp: 8,
  MFTransactionTypes.assistedService: 9,
  MFTransactionTypes.basket: 10,
  MFTransactionTypes.cart: 11,
};

const _$SystematicPlansStatusEnumMap = {
  SystematicPlansStatus.activated: 'ACTIVATED',
  SystematicPlansStatus.deactivated: 'DEACTIVATED',
  SystematicPlansStatus.success: 'SUCCESS',
};
