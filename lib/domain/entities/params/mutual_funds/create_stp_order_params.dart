import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_stp_order_params.g.dart';

@JsonSerializable()
class CreateStpOrderParams {
  //{
  //     "userId": 220,
  //     "transactionTypeId":5,
  //     "fundAmount": 6000,
  //     "folioNumber": "RBM05NTEAXUY6",
  //     "frequency": "MONTHLY",
  //     "startDate": "2022-08-01",
  //     "endDate": "2023-08-01",
  //     "fpMaxStpInAmount": 5000.0,
  //     "fpMinStpInAmount": 5000.0,
  //     "numberOfInstallments": 14,
  //     "switchInPlan": "100784",
  //     "switchOutPlan": "149532",
  //     "fpStpInAllowed": true,
  //     "switchInisin": "INF109K01AS1",
  //     "switchOutisin": "INF109K01365",
  //     "switchInSchemeName": "Sundaram Asset Management Company Limited- In cap",
  //     "switchOutSchemeName": "Sundaram Asset Management Company Limited- OUt cap ",
  //     "switchInImgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
  //     "switchOutImgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png"
  //
  // }

  final int userId;
  @JsonKey(name: 'transactionTypeId')
  final MFTransactionTypes transactionType;
  final double fundAmount;
  final String folioNumber;
  final String frequency;
  @JsonKey(toJson: _dateTimeToString)
  final DateTime startDate;
  final DateTime? endDate;
  final double fpMaxStpInAmount;
  final double fpMinStpInAmount;
  final int numberOfInstallments;
  final String switchInPlan;
  final String switchOutPlan;
  final bool fpStpInAllowed;
  final String switchInisin;
  final String switchOutisin;
  final String switchInSchemeName;
  final String switchOutSchemeName;
  final String switchInImgUrl;
  final String switchOutImgUrl;

  CreateStpOrderParams({
    required this.userId,
    this.transactionType = MFTransactionTypes.stp,
    required this.fundAmount,
    required this.folioNumber,
    this.frequency = "MONTHLY",
    required this.startDate,
    this.endDate,
    required this.fpMaxStpInAmount,
    required this.fpMinStpInAmount,
    required this.numberOfInstallments,
    required this.switchInPlan,
    required this.switchOutPlan,
    required this.fpStpInAllowed,
    required this.switchInisin,
    required this.switchOutisin,
    required this.switchInSchemeName,
    required this.switchOutSchemeName,
    required this.switchInImgUrl,
    required this.switchOutImgUrl,
  })  : assert(transactionType == MFTransactionTypes.stp,
            'transactionType must be stp'),
        assert(frequency == 'MONTHLY', 'frequency must be MONTHLY');

  factory CreateStpOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateStpOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStpOrderParamsToJson(this);

  static _dateTimeToString(DateTime dateTime) =>
      dateTime.toIso8601String().substring(0, 10);
}
