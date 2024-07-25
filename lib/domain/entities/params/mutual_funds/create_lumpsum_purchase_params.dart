import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_lumpsum_purchase_params.g.dart';

@JsonSerializable()
class CreateLumpsumPurchaseParams {
  //{
  // "userId": 220,
  // "transactionTypeId": 1,
  // "fundPlanId": "149532",
  // "fundAmount" : 2000,
  // "fundFolioNumber": "RBM05NTEAXUY6",
  // "isin": "INF173K01189",
  // "nav": 100.9043,
  // "amcId": "AMC35",
  // "planName": "Sundaram Asset Management Company Limited-cap"
  // }
  final String userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final String fundPlanId;
  final double fundAmount;
  final String? fundFolioNumber;
  final String isin;
  final double nav;
  final String amcId;
  final String planName;
  final int mfLumpsumConsentId;

  CreateLumpsumPurchaseParams({
    required this.userId,
    required this.fundPlanId,
    required this.fundAmount,
    this.fundFolioNumber,
    required this.isin,
    required this.nav,
    required this.amcId,
    required this.planName,
    required this.mfLumpsumConsentId,

    this.transactionType = MFTransactionTypes.lumpsum,
  }) : assert(

            /// The transaction type should be lumpsum and should not be changed
            transactionType == MFTransactionTypes.lumpsum,
            "The transaction type should be lumpsum and should not be changed");

  factory CreateLumpsumPurchaseParams.fromJson(Map<String, dynamic> json) =>
      _$CreateLumpsumPurchaseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLumpsumPurchaseParamsToJson(this);
}
