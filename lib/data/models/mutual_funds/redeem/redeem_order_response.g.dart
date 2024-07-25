// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedeemOrderResponse _$RedeemOrderResponseFromJson(Map<String, dynamic> json) =>
    RedeemOrderResponse(
      id: json['id'] as int,
      oldId: json['oldId'] as int,
      mfInvestmentAccountId: json['mfInvestmentAccountId'] as String,
      folioNumber: json['folioNumber'] as String,
      state: json['state'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      scheme: json['scheme'] as String,
      redemptionMode: json['redemptionMode'] as String,
      tradedOn: json['tradedOn'] == null
          ? null
          : DateTime.parse(json['tradedOn'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
      plan: json['plan'] as String?,
      euin: json['euin'] as String?,
      distributorId: json['distributorId'] as String?,
      units: (json['units'] as num?)?.toDouble(),
      redeemedPrice: (json['redeemedPrice'] as num?)?.toDouble(),
      redeemedUnits: json['redeemedUnits'] as String?,
      redeemedAmount: (json['redeemedAmount'] as num?)?.toDouble(),
      redemptionBankAccountNumber:
          json['redemptionBankAccountNumber'] as String?,
      redemptionBankAccountIfscCode:
          json['redemptionBankAccountIfscCode'] as String?,
      scheduledOn: json['scheduledOn'] == null
          ? null
          : DateTime.parse(json['scheduledOn'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      succeededAt: json['succeededAt'] == null
          ? null
          : DateTime.parse(json['succeededAt'] as String),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      reversedAt: json['reversedAt'] == null
          ? null
          : DateTime.parse(json['reversedAt'] as String),
      gateway: json['gateway'] as String?,
      initiatedBy: json['initiatedBy'] as String?,
      initiatedVia: json['initiatedVia'] as String?,
      sourceRefId: json['sourceRefId'] as String?,
      userIp: json['userIp'] as String?,
      serverIp: json['serverIp'] as String?,
      tenantId: json['tenantId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool,
      mfRedemptionId: json['mfRedemptionId'] as String,
      navAsOn: (json['navAsOn'] as num).toDouble(),
      calculatedUnits: (json['calculatedUnits'] as num).toDouble(),
      isMailSent: json['isMailSent'] as bool,
      isFull: json['isFull'] as bool,
      otpVerified: json['otpVerified'] as bool,
      otpString: json['otpString'] as String,
      otpCount: json['otpCount'] as int,
      deleted: json['deleted'] as bool,
    );

Map<String, dynamic> _$RedeemOrderResponseToJson(
        RedeemOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oldId': instance.oldId,
      'mfInvestmentAccountId': instance.mfInvestmentAccountId,
      'folioNumber': instance.folioNumber,
      'state': instance.state,
      'amount': instance.amount,
      'scheme': instance.scheme,
      'redemptionMode': instance.redemptionMode,
      'tradedOn': instance.tradedOn?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
      'plan': instance.plan,
      'euin': instance.euin,
      'distributorId': instance.distributorId,
      'units': instance.units,
      'redeemedPrice': instance.redeemedPrice,
      'redeemedUnits': instance.redeemedUnits,
      'redeemedAmount': instance.redeemedAmount,
      'redemptionBankAccountNumber': instance.redemptionBankAccountNumber,
      'redemptionBankAccountIfscCode': instance.redemptionBankAccountIfscCode,
      'scheduledOn': instance.scheduledOn?.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'succeededAt': instance.succeededAt?.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'reversedAt': instance.reversedAt?.toIso8601String(),
      'gateway': instance.gateway,
      'initiatedBy': instance.initiatedBy,
      'initiatedVia': instance.initiatedVia,
      'sourceRefId': instance.sourceRefId,
      'userIp': instance.userIp,
      'serverIp': instance.serverIp,
      'tenantId': instance.tenantId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'mfRedemptionId': instance.mfRedemptionId,
      'navAsOn': instance.navAsOn,
      'calculatedUnits': instance.calculatedUnits,
      'isMailSent': instance.isMailSent,
      'isFull': instance.isFull,
      'otpVerified': instance.otpVerified,
      'otpString': instance.otpString,
      'otpCount': instance.otpCount,
      'deleted': instance.deleted,
    };
