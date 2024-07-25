import 'package:json_annotation/json_annotation.dart';

part 'verify_cart_purchase_response.g.dart';

@JsonSerializable()
class VerifyCartPurchaseOtpResponse {
  final String tokenUrl;
  final String status;

  VerifyCartPurchaseOtpResponse({
    required this.tokenUrl,
    required this.status,
  });

  factory VerifyCartPurchaseOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCartPurchaseOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCartPurchaseOtpResponseToJson(this);
}
