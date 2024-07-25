import 'package:json_annotation/json_annotation.dart';

part 'basket_sip_order_verify_params.g.dart';

@JsonSerializable()
class BasketSipOrderVerifyParams {
  const BasketSipOrderVerifyParams({
    required this.orderRef,
    required this.consentId,
    required this.otp,
  });

  final String orderRef;
  @JsonKey(name: 'consentID')
  final int consentId;
  final String otp;

  factory BasketSipOrderVerifyParams.fromJson(Map<String, dynamic> json) =>
      _$BasketSipOrderVerifyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketSipOrderVerifyParamsToJson(this);
}
