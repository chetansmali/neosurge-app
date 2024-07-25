import 'package:json_annotation/json_annotation.dart';

part 'initiate_cart_sip_purchase_params.g.dart';

@JsonSerializable()
class InitiateCartSipPurchaseParams {
  @JsonKey(name: 'mandateID')
  final int mandateId;

  InitiateCartSipPurchaseParams({
    required this.mandateId,
  });

  factory InitiateCartSipPurchaseParams.fromJson(Map<String, dynamic> json) =>
      _$InitiateCartSipPurchaseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InitiateCartSipPurchaseParamsToJson(this);
}
