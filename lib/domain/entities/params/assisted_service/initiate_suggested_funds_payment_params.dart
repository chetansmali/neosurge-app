import 'package:json_annotation/json_annotation.dart';

part 'initiate_suggested_funds_payment_params.g.dart';

@JsonSerializable()
class InitiateSuggestedFundsPaymentParams {
  //{
  //     "userId": 220,
  //     "paymentType": "NETBANKING",
  //     "euin": "E260421",
  //     "referenceCode" : "",
  //     "ids": [366,367,368,369,371],
  //     "isWeb": true
  // }

  final int userId;
  final String paymentType;
  final String? euin;
  final String? referenceCode;
  final List<int> ids;
  final bool isWeb;

  InitiateSuggestedFundsPaymentParams({
    required this.userId,
    this.paymentType = "NETBANKING",
    this.euin,
    this.referenceCode,
    required this.ids,
    this.isWeb = false,
  })  : assert(paymentType == "NETBANKING",
            "paymentType can only be NETBANKING for now"),
        assert(isWeb == false, "isWeb will be true only for web");

  factory InitiateSuggestedFundsPaymentParams.fromJson(
          Map<String, dynamic> json) =>
      _$InitiateSuggestedFundsPaymentParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InitiateSuggestedFundsPaymentParamsToJson(this);
}
