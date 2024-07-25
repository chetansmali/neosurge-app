import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_swp_order_params.g.dart';

@JsonSerializable()
class CreateSwpOrderParams {
  //{
  //     "userId": 220,
  //     "transactionTypeId":6,
  //     "fundAmount": 500,
  //     "folioNumber": "RBM05NTEAXUY6",
  //     "isin": "INF173K01189",
  //     "fundPlanId": "149532",
  //     "schemeName": "Sundaram Asset Management Company Limited",
  //     "imgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
  //     "minSwpAmount": 500.0,
  //     "maxSwpAmount": 99999999.0,
  //     "numberOfInstallments": 14,
  //     "frequency": "monthly",
  //     "startDate": "2022-07-01",
  //     "endDate": null,
  //     "swpAllowed":true
  // }

  final int userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final double fundAmount;
  final String folioNumber;
  final String isin;
  final String fundPlanId;
  final String schemeName;
  final String imgUrl;
  final double minSwpAmount;
  final double maxSwpAmount;
  final int numberOfInstallments;
  final String frequency;
  @JsonKey(toJson: _dateTimeToString)
  final DateTime startDate;

  final DateTime? endDate;
  final bool swpAllowed;

  CreateSwpOrderParams({
    required this.userId,
    this.transactionType = MFTransactionTypes.swp,
    required this.fundAmount,
    required this.folioNumber,
    required this.isin,
    required this.fundPlanId,
    required this.schemeName,
    required this.imgUrl,
    required this.minSwpAmount,
    required this.maxSwpAmount,
    required this.numberOfInstallments,
    this.frequency = 'MONTHLY',
    required this.startDate,
    this.endDate,
    required this.swpAllowed,
  })  : assert(frequency == 'MONTHLY', 'frequency must be monthly'),
        assert(transactionType == MFTransactionTypes.swp,
            'transactionType must be swp');

  factory CreateSwpOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateSwpOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSwpOrderParamsToJson(this);

  static _dateTimeToString(DateTime dateTime) =>
      dateTime.toIso8601String().substring(0, 10);
}
