import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_switch_order_params.g.dart';

@JsonSerializable()
class CreateSwitchOrderParams {
  //{
  //     "userId": 220,
  //     "transactionTypeId":4,
  //     "fundAmount": 5000,
  //     "folioNumber": "RBM05NTEAXUY6",
  //     "nav": 10.0,
  //     "schemeOutIsin": "INF173K01189",
  //     "schemeInIsin": "INF903J01IN3",
  //     "schemeOutFundPlanId": "149532",
  //     "schemeInFundPlanId": "100784",
  //     "schemeOutSwitchOutMinAmt": 5000,
  //     "schemeInSwitchInAllowed": true,
  //     "switchInSchemeName":"Sundaram Asset Management Company Limited-IN cap",
  //     "switchOutSchemeName":"Sundaram Asset Management Company Limited- OUt cap",
  //     "switchInImgUrl":"https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
  //     "switchOutImgUrl":"https://bullsurge.mindstack.in/ff/amclogo/AMC35.png"
  //
  // }

  final int userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final double? fundAmount;
  final double? units;
  final String folioNumber;
  final double nav;
  final String schemeOutIsin;
  final String schemeInIsin;
  final String schemeOutFundPlanId;
  final String schemeInFundPlanId;
  final double switchOutMinAmt;
  final bool switchInAllowed;
  final String switchInSchemeName;
  final String switchOutSchemeName;
  final String switchInImgUrl;
  final String switchOutImgUrl;
  final bool isAssisted;

  CreateSwitchOrderParams({
    required this.userId,
    this.fundAmount,
    this.units,
    required this.folioNumber,
    required this.nav,
    required this.schemeOutIsin,
    required this.schemeInIsin,
    required this.schemeOutFundPlanId,
    required this.schemeInFundPlanId,
    required this.switchOutMinAmt,
    required this.switchInAllowed,
    required this.switchInSchemeName,
    required this.switchOutSchemeName,
    required this.switchInImgUrl,
    required this.switchOutImgUrl,
    this.transactionType = MFTransactionTypes.switchTransaction,
    this.isAssisted = false,
  })  : assert(fundAmount == null || units == null,
            'Both fundAmount and units cannot be null at the same time.'),
        assert(transactionType == MFTransactionTypes.switchTransaction,
            'Only switch transaction type is allowed.');

  factory CreateSwitchOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateSwitchOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSwitchOrderParamsToJson(this);
}
