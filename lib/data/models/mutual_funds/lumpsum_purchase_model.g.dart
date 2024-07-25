// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lumpsum_purchase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LumpsumPurchase _$LumpsumPurchaseFromJson(Map<String, dynamic> json) =>
    LumpsumPurchase(
      id: json['id'] as int,
      planId: json['planId'] as String,
      mfFolioInfoId: json['mfFolioInfoId'] as int?,
      mfId: json['mfId'] as String,
      mfOldId: json['mfOldId'] as int,
      mfInvestmentAccountId: json['mfInvestmentAccountId'] as String,
      folioNumber: json['folioNumber'] as String?,
      state: json['state'] as String,
      amount: (json['amount'] as num).toDouble(),
      allottedUnits: (json['allottedUnits'] as num?)?.toDouble(),
      purchaseAmount: (json['purchaseAmount'] as num?)?.toDouble(),
      purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
      scheme: json['scheme'] as String,
      type: json['type'] as String,
      plan: json['plan'] as String?,
      scheduledOn: json['scheduledOn'] == null
          ? null
          : DateTime.parse(json['scheduledOn'] as String),
      tradedOn: json['tradedOn'] == null
          ? null
          : DateTime.parse(json['tradedOn'] as String),
      confirmedAt: DateTime.parse(json['confirmedAt'] as String),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      succeededAt: json['succeededAt'] == null
          ? null
          : DateTime.parse(json['succeededAt'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
      reversedAt: json['reversedAt'] == null
          ? null
          : DateTime.parse(json['reversedAt'] as String),
      gateway: json['gateway'] as String,
      sourceRefId: json['sourceRefId'] as String,
      userIp: json['userIp'] as String?,
      serverIp: json['serverIp'] as String?,
      euin: json['euin'] as String,
      distributorId: json['distributorId'] as String?,
      initiatedBy: json['initiatedBy'] as String?,
      initiatedVia: json['initiatedVia'] as String?,
      transactionId: json['transactionId'] as String?,
      navAsOn: (json['navAsOn'] as num).toDouble(),
      calculatedUnits: (json['calculatedUnits'] as num).toDouble(),
      paymentMode: json['paymentMode'] as String,
      referenceCode: json['referenceCode'] as String?,
      amcLogo: AmcLogo.fromJson(json['amcLogo'] as Map<String, dynamic>),
      planName: json['planName'] as String,
      transactionStatus: json['transactionStatus'] as String,
      transactionAt: json['transactionAt'] == null
          ? null
          : DateTime.parse(json['transactionAt'] as String),
    );

Map<String, dynamic> _$LumpsumPurchaseToJson(LumpsumPurchase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'mfFolioInfoId': instance.mfFolioInfoId,
      'mfId': instance.mfId,
      'mfOldId': instance.mfOldId,
      'mfInvestmentAccountId': instance.mfInvestmentAccountId,
      'folioNumber': instance.folioNumber,
      'state': instance.state,
      'amount': instance.amount,
      'allottedUnits': instance.allottedUnits,
      'purchaseAmount': instance.purchaseAmount,
      'purchasePrice': instance.purchasePrice,
      'scheme': instance.scheme,
      'type': instance.type,
      'plan': instance.plan,
      'scheduledOn': instance.scheduledOn?.toIso8601String(),
      'tradedOn': instance.tradedOn?.toIso8601String(),
      'confirmedAt': instance.confirmedAt.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'succeededAt': instance.succeededAt?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
      'reversedAt': instance.reversedAt?.toIso8601String(),
      'gateway': instance.gateway,
      'sourceRefId': instance.sourceRefId,
      'userIp': instance.userIp,
      'serverIp': instance.serverIp,
      'euin': instance.euin,
      'distributorId': instance.distributorId,
      'initiatedBy': instance.initiatedBy,
      'initiatedVia': instance.initiatedVia,
      'transactionId': instance.transactionId,
      'transactionStatus': instance.transactionStatus,
      'transactionAt': instance.transactionAt?.toIso8601String(),
      'navAsOn': instance.navAsOn,
      'calculatedUnits': instance.calculatedUnits,
      'paymentMode': instance.paymentMode,
      'referenceCode': instance.referenceCode,
      'amcLogo': instance.amcLogo,
      'planName': instance.planName,
    };
