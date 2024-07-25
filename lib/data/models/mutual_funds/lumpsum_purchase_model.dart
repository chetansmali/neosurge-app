import 'package:json_annotation/json_annotation.dart';

import 'amc_logo.dart';

part 'lumpsum_purchase_model.g.dart';

@JsonSerializable()
class LumpsumPurchase {
  final int id;
  final String planId;
  final int? mfFolioInfoId;
  final String mfId;
  final int mfOldId;
  final String mfInvestmentAccountId;
  final String? folioNumber;
  final String state;
  final double amount;
  final double? allottedUnits;
  final double? purchaseAmount;
  final double? purchasePrice;
  final String scheme;
  final String type;
  final String? plan;
  final DateTime? scheduledOn;
  final DateTime? tradedOn;
  final DateTime confirmedAt;
  final DateTime? submittedAt;
  final DateTime? succeededAt;
  final DateTime? failedAt;
  final DateTime? reversedAt;
  final String gateway;
  final String sourceRefId;
  final String? userIp;
  final String? serverIp;
  final String euin;
  final String? distributorId;
  final String? initiatedBy;
  final String? initiatedVia;
  final String? transactionId;
  final String transactionStatus;
  final DateTime? transactionAt;
  final double navAsOn;
  final double calculatedUnits;
  final String paymentMode;
  final String? referenceCode;
  final AmcLogo amcLogo;
  final String planName;

  LumpsumPurchase({
    required this.id,
    required this.planId,
    this.mfFolioInfoId,
    required this.mfId,
    required this.mfOldId,
    required this.mfInvestmentAccountId,
    this.folioNumber,
    required this.state,
    required this.amount,
    this.allottedUnits,
    this.purchaseAmount,
    this.purchasePrice,
    required this.scheme,
    required this.type,
    this.plan,
    this.scheduledOn,
    this.tradedOn,
    required this.confirmedAt,
    this.submittedAt,
    this.succeededAt,
    this.failedAt,
    this.reversedAt,
    required this.gateway,
    required this.sourceRefId,
    this.userIp,
    this.serverIp,
    required this.euin,
    this.distributorId,
    this.initiatedBy,
    this.initiatedVia,
    this.transactionId,
    required this.navAsOn,
    required this.calculatedUnits,
    required this.paymentMode,
    this.referenceCode,
    required this.amcLogo,
    required this.planName,
    required this.transactionStatus,
    this.transactionAt,
  });

  factory LumpsumPurchase.fromJson(Map<String, dynamic> json) =>
      _$LumpsumPurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$LumpsumPurchaseToJson(this);
}
