import 'package:json_annotation/json_annotation.dart';

part 'basket_sip_order_verify_response.g.dart';

@JsonSerializable()
class BasketSipOrderVerifyResponse {
  @JsonKey(name: 'tokenURL')
  final String tokenUrl;

  const BasketSipOrderVerifyResponse({
    required this.tokenUrl,
  });

  factory BasketSipOrderVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$BasketSipOrderVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasketSipOrderVerifyResponseToJson(this);
}
