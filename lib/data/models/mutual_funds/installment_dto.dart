import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'installment_dto.g.dart';

@JsonSerializable()
class InstallmentDTO {
  final int id;
  final MFPurchaseType type;
  final String status;
  final double amount;
  final double? units;
  final double? reverseAmount;
  final double? reverseUnits;
  final double? price;
  final double? switchInPrice;
  final double? switchInUnits;
  final DateTime? tradedOn;
  final DateTime investmentDate;
  final String? folioNumber;
  final int? bankAccountId;
  final int? sourceRefId;
  final int sipId;
  final String? redemptionMode;
  final String? redemptionBankAccountNumber;
  final String? redemptionBankAccountIfscCode;
  final DateTime? confirmedAt;
  final DateTime? submittedAt;
  final DateTime? succeededAt;
  final DateTime? reversedAt;
  final DateTime? failedAt;
  final DateTime createdAt;
  final MFFundScheme fundScheme;
  final MFFundScheme? switchInFundScheme;
  final String? initiatedBy;
  final String? initiatedVia;

  InstallmentDTO({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    this.units,
    this.reverseAmount,
    this.reverseUnits,
    this.price,
    this.switchInPrice,
    this.switchInUnits,
    this.tradedOn,
    required this.investmentDate,
    this.folioNumber,
    this.bankAccountId,
    this.sourceRefId,
    required this.sipId,
    this.redemptionMode,
    this.redemptionBankAccountNumber,
    this.redemptionBankAccountIfscCode,
    this.confirmedAt,
    required this.submittedAt,
    this.succeededAt,
    this.reversedAt,
    this.failedAt,
    required this.createdAt,
    required this.fundScheme,
    this.switchInFundScheme,
    this.initiatedBy,
    this.initiatedVia,
  });

  factory InstallmentDTO.fromJson(Map<String, dynamic> json) =>
      _$InstallmentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$InstallmentDTOToJson(this);
}

@JsonSerializable()
class MFFundScheme {
  final int id;
  final String name;
  final String isin;
  final String schemeCode;

  MFFundScheme({
    required this.id,
    required this.name,
    required this.isin,
    required this.schemeCode,
  });

  factory MFFundScheme.fromJson(Map<String, dynamic> json) =>
      _$MFFundSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$MFFundSchemeToJson(this);
}
