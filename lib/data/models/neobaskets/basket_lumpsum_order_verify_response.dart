import 'package:json_annotation/json_annotation.dart';

part 'basket_lumpsum_order_verify_response.g.dart';

@JsonSerializable()
class BasketLumpsumOrderVerifyResponse {
  @JsonKey(name: 'tokenURL')
  final String tokenUrl;

  const BasketLumpsumOrderVerifyResponse({
    required this.tokenUrl,
  });

  factory BasketLumpsumOrderVerifyResponse.fromJson(
          Map<String, dynamic> json) =>
      _$BasketLumpsumOrderVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BasketLumpsumOrderVerifyResponseToJson(this);
}
