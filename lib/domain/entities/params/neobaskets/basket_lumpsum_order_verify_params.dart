import 'package:json_annotation/json_annotation.dart';

part 'basket_lumpsum_order_verify_params.g.dart';

@JsonSerializable()
class BasketLumpsumOrderVerifyParams {
  const BasketLumpsumOrderVerifyParams({
    required this.orderRef,
    required this.consentId,
    required this.otp,
  });

  final String orderRef;
  @JsonKey(name: 'consentID')
  final int consentId;
  final String otp;

  factory BasketLumpsumOrderVerifyParams.fromJson(Map<String, dynamic> json) =>
      _$BasketLumpsumOrderVerifyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketLumpsumOrderVerifyParamsToJson(this);
}
