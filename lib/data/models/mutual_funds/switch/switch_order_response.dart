import 'package:json_annotation/json_annotation.dart';

part 'switch_order_response.g.dart';

@JsonSerializable()
class SwitchOrderResponse {
  //{
  //         "id": 27,
  //         "switchId": null,
  //         "state": null,
  //         "status": "INPROGRESS",
  //         "amount": 0.0,
  //         "folioNumber": "RBM05NTEAXUY6",
  //         "schemeInFundPlanId": "100784",
  //         "schemeOutFundPlanId": "149532",
  //         "switchInSchemeName": "Sundaram Asset Management Company Limited-IN cap",
  //         "switchOutSchemeName": "Sundaram Asset Management Company Limited- OUt cap",
  //         "switchInImgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
  //         "switchOutImgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC35.png",
  //         "schemeInIsin": "INF903J01IN3",
  //         "schemeOutIsin": "INF173K01189",
  //         "units": 20.0
  //     }

  final int id;
  final int? switchId;
  final String? state;
  final String status;
  final double amount;
  final String folioNumber;
  final String schemeInFundPlanId;
  final String schemeOutFundPlanId;
  final String switchInSchemeName;
  final String switchOutSchemeName;
  final String switchInImgUrl;
  final String switchOutImgUrl;
  final String schemeInIsin;
  final String schemeOutIsin;
  final double? units;

  SwitchOrderResponse({
    required this.id,
    this.switchId,
    this.state,
    required this.status,
    required this.amount,
    required this.folioNumber,
    required this.schemeInFundPlanId,
    required this.schemeOutFundPlanId,
    required this.switchInSchemeName,
    required this.switchOutSchemeName,
    required this.switchInImgUrl,
    required this.switchOutImgUrl,
    required this.schemeInIsin,
    required this.schemeOutIsin,
    this.units,
  });

  factory SwitchOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$SwitchOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchOrderResponseToJson(this);
}
