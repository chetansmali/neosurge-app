import 'package:json_annotation/json_annotation.dart';

part 'basket_redeem_order_response.g.dart';

@JsonSerializable()
class BasketRedeemOrderResponse {
  final String redemptionRef;
  final String? name;
  final double? amount;
  final double? exitLoad;
  final double? redeemableAmount;
  final List<BankDetails> bankDetails;

  BasketRedeemOrderResponse({
    required this.redemptionRef,
    required this.name,
    required this.amount,
    required this.exitLoad,
    required this.redeemableAmount,
    required this.bankDetails,
  });

  factory BasketRedeemOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketRedeemOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketRedeemOrderResponseToJson(this);
}

@JsonSerializable()
class BankDetails {
  final String? bankName;
  final String? accountNumber;

  BankDetails({
    required this.bankName,
    required this.accountNumber,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);
}
