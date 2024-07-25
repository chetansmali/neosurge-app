import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_sip_order_params.g.dart';

@JsonSerializable()
class CreateSipOrderParams {
  //{
  //     "userId": 220,
  //     "transactionTypeId": 2,
  //     "fundPlanId": "100528",
  //     "fundAmount" : 111112,
  //     "fundSubPlanId": null,
  //     "fundFolioNumber": null,
  //     "numberOfInstallments": 12,
  //     "frequency":"MONTHLY",
  //     "startDate":"2022-06-28",
  //     "endDate":"",
  //     "isin": "INF090I01DG6",
  //     "nav": 100.9043
  // }

  final int userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final String fundPlanId;
  final double fundAmount;
  final String? fundSubPlanId;
  final String? fundFolioNumber;
  final int numberOfInstallments;
  final String frequency;
  final String startDate;
  final String? endDate;
  final String isin;
  final double nav;
  final bool isWeb;
  final String amcId;
  final String planName;
  final int mfSipConsentId;

  CreateSipOrderParams({
    required this.userId,
    required this.fundPlanId,
    required this.fundAmount,
    this.fundSubPlanId,
    this.fundFolioNumber,
    required this.numberOfInstallments,
    required this.startDate,
    this.endDate,
    required this.isin,
    required this.nav,
    this.frequency = "MONTHLY",
    this.transactionType = MFTransactionTypes.sip,
    this.isWeb = false,
    required this.amcId,
    required this.planName,
    required this.mfSipConsentId,
  })  : assert(transactionType == MFTransactionTypes.sip,
            "The transaction type should be sip and should not be changed"),
        assert(frequency == "MONTHLY", "The frequency should be MONTHLY"),
        assert(isWeb == false, "The isWeb should be false");

  factory CreateSipOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateSipOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSipOrderParamsToJson(this);
}
