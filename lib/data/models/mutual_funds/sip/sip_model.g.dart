// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SipModel _$SipModelFromJson(Map<String, dynamic> json) => SipModel(
      id: json['id'] as int,
      isin: json['isin'] as String,
      amount: (json['amount'] as num).toDouble(),
      startDay: json['startDay'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      nextSipDate: DateTime.parse(json['nextSipDate'] as String),
      frequency: json['frequency'] as String,
      installments: json['installments'] as int,
      folioNumber: json['folioNumber'] as String?,
      mandateId: json['mandateId'] as int,
      sourceRefId: json['sourceRefId'] as String,
      userIp: json['userIp'] as String,
      serverIp: json['serverIp'] as String,
      status: $enumDecode(_$SystematicPlansStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      sipId: json['sipId'] as int,
      navAsOn: (json['navAsOn'] as num).toDouble(),
      calculatedUnits: (json['calculatedUnits'] as num).toDouble(),
      activatedAt: json['activatedAt'] == null
          ? null
          : DateTime.parse(json['activatedAt'] as String),
      sipInternalStatus:
          $enumDecode(_$SipInternalStatusEnumMap, json['sipInternalStatus']),
      sipInternalStatusDate:
          DateTime.parse(json['sipInternalStatusDate'] as String),
      plan: json['plan'] as String,
      sipDueTriggered: json['sipDueTriggered'] as bool,
      planName: json['planName'] as String,
      amcLogo: AmcLogo.fromJson(json['amcLogo'] as Map<String, dynamic>),
      deleted: json['deleted'] as bool,
    );

Map<String, dynamic> _$SipModelToJson(SipModel instance) => <String, dynamic>{
      'id': instance.id,
      'isin': instance.isin,
      'amount': instance.amount,
      'startDay': instance.startDay,
      'startDate': instance.startDate.toIso8601String(),
      'nextSipDate': instance.nextSipDate.toIso8601String(),
      'frequency': instance.frequency,
      'installments': instance.installments,
      'folioNumber': instance.folioNumber,
      'mandateId': instance.mandateId,
      'sourceRefId': instance.sourceRefId,
      'userIp': instance.userIp,
      'serverIp': instance.serverIp,
      'status': _$SystematicPlansStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'sipId': instance.sipId,
      'navAsOn': instance.navAsOn,
      'calculatedUnits': instance.calculatedUnits,
      'activatedAt': instance.activatedAt?.toIso8601String(),
      'sipInternalStatus':
          _$SipInternalStatusEnumMap[instance.sipInternalStatus]!,
      'sipInternalStatusDate': instance.sipInternalStatusDate.toIso8601String(),
      'plan': instance.plan,
      'planName': instance.planName,
      'amcLogo': instance.amcLogo,
      'sipDueTriggered': instance.sipDueTriggered,
      'deleted': instance.deleted,
    };

const _$SystematicPlansStatusEnumMap = {
  SystematicPlansStatus.activated: 'ACTIVATED',
  SystematicPlansStatus.deactivated: 'DEACTIVATED',
  SystematicPlansStatus.success: 'SUCCESS',
};

const _$SipInternalStatusEnumMap = {
  SipInternalStatus.initiated: 'initated',
  SipInternalStatus.submitted: 'submitted',
};
