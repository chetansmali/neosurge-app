// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentDTO _$InstallmentDTOFromJson(Map<String, dynamic> json) =>
    InstallmentDTO(
      id: json['id'] as int,
      type: $enumDecode(_$MFPurchaseTypeEnumMap, json['type']),
      status: json['status'] as String,
      amount: (json['amount'] as num).toDouble(),
      units: (json['units'] as num?)?.toDouble(),
      reverseAmount: (json['reverseAmount'] as num?)?.toDouble(),
      reverseUnits: (json['reverseUnits'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      switchInPrice: (json['switchInPrice'] as num?)?.toDouble(),
      switchInUnits: (json['switchInUnits'] as num?)?.toDouble(),
      tradedOn: json['tradedOn'] == null
          ? null
          : DateTime.parse(json['tradedOn'] as String),
      investmentDate: DateTime.parse(json['investmentDate'] as String),
      folioNumber: json['folioNumber'] as String?,
      bankAccountId: json['bankAccountId'] as int?,
      sourceRefId: json['sourceRefId'] as int?,
      sipId: json['sipId'] as int,
      redemptionMode: json['redemptionMode'] as String?,
      redemptionBankAccountNumber:
          json['redemptionBankAccountNumber'] as String?,
      redemptionBankAccountIfscCode:
          json['redemptionBankAccountIfscCode'] as String?,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      succeededAt: json['succeededAt'] == null
          ? null
          : DateTime.parse(json['succeededAt'] as String),
      reversedAt: json['reversedAt'] == null
          ? null
          : DateTime.parse(json['reversedAt'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      fundScheme:
          MFFundScheme.fromJson(json['fundScheme'] as Map<String, dynamic>),
      switchInFundScheme: json['switchInFundScheme'] == null
          ? null
          : MFFundScheme.fromJson(
              json['switchInFundScheme'] as Map<String, dynamic>),
      initiatedBy: json['initiatedBy'] as String?,
      initiatedVia: json['initiatedVia'] as String?,
    );

Map<String, dynamic> _$InstallmentDTOToJson(InstallmentDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MFPurchaseTypeEnumMap[instance.type]!,
      'status': instance.status,
      'amount': instance.amount,
      'units': instance.units,
      'reverseAmount': instance.reverseAmount,
      'reverseUnits': instance.reverseUnits,
      'price': instance.price,
      'switchInPrice': instance.switchInPrice,
      'switchInUnits': instance.switchInUnits,
      'tradedOn': instance.tradedOn?.toIso8601String(),
      'investmentDate': instance.investmentDate.toIso8601String(),
      'folioNumber': instance.folioNumber,
      'bankAccountId': instance.bankAccountId,
      'sourceRefId': instance.sourceRefId,
      'sipId': instance.sipId,
      'redemptionMode': instance.redemptionMode,
      'redemptionBankAccountNumber': instance.redemptionBankAccountNumber,
      'redemptionBankAccountIfscCode': instance.redemptionBankAccountIfscCode,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'succeededAt': instance.succeededAt?.toIso8601String(),
      'reversedAt': instance.reversedAt?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'fundScheme': instance.fundScheme,
      'switchInFundScheme': instance.switchInFundScheme,
      'initiatedBy': instance.initiatedBy,
      'initiatedVia': instance.initiatedVia,
    };

const _$MFPurchaseTypeEnumMap = {
  MFPurchaseType.purchase: 'PURCHASE',
  MFPurchaseType.additionalPurchase: 'ADDITIONAL_PURCHASE',
};

MFFundScheme _$MFFundSchemeFromJson(Map<String, dynamic> json) => MFFundScheme(
      id: json['id'] as int,
      name: json['name'] as String,
      isin: json['isin'] as String,
      schemeCode: json['schemeCode'] as String,
    );

Map<String, dynamic> _$MFFundSchemeToJson(MFFundScheme instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isin': instance.isin,
      'schemeCode': instance.schemeCode,
    };
