import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_redemption_order_params.g.dart';

@JsonSerializable()
class CreateRedemptionOrderParams {
  //    {
  //         "userId" : 220,
  //         "transactionTypeId" : 3,
  // 	    "paymentType": "NETBANKING",
  // 	    "euin" : "E260421",
  // 	    "isinCode": "INF209KB1ZC3",
  // 	    "fundAmount": 1000,
  //         "units": null,
  //         "folioNumber": "8838178888718",
  //         "sourceRefId": "mf_116#220",
  //         "userIp": "10.0.128.12",
  //         "serverIp": "126.1.10.1"
  //     }

  final int userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final MFPaymentTypes paymentType;
  final String? euin;
  final String isinCode;
  final double? fundAmount;
  final String fundName;
  final double? fundUnits;
  final String? folioNumber;
  final String? sourceRefId;
  final String? userIp;
  final String? serverIp;
  final bool isAssisted;
  final bool isRedeemAll;

  CreateRedemptionOrderParams({
    required this.userId,
    required this.paymentType,
    this.euin,
    required this.isinCode,
    required this.fundName,
    this.fundAmount,
    this.fundUnits,
    this.folioNumber,
    this.sourceRefId,
    this.userIp,
    this.serverIp,
    this.isAssisted = false,
    this.isRedeemAll=false,
    this.transactionType = MFTransactionTypes.redemption,
  })  : assert(fundAmount == null || fundUnits == null,
            'Both fundAmount and units cannot be null at the same time.'),
        assert(transactionType == MFTransactionTypes.redemption,
            'Only redemption transaction type is allowed.');

  factory CreateRedemptionOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateRedemptionOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRedemptionOrderParamsToJson(this);
}
