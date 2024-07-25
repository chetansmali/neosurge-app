import 'package:json_annotation/json_annotation.dart';

part 'initiate_lumpsum_cart_purchase_response.g.dart';

@JsonSerializable()
class InitiateCartPurchaseResponse {
  @JsonKey(name: 'cartPurchaseID')
  final String cartPurchaseId;
  final String status;

  InitiateCartPurchaseResponse({
    required this.cartPurchaseId,
    required this.status,
  });

  factory InitiateCartPurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiateCartPurchaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitiateCartPurchaseResponseToJson(this);
}
