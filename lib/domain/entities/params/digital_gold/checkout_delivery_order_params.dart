import 'package:json_annotation/json_annotation.dart';

part 'checkout_delivery_order_params.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutDeliveryOrderParams {
  final String shippingUserAddressId;
  final String billingUserAddressId;
  final bool isShippingSameAsBilling;
  @JsonKey(
    name: 'product',
  )
  final List<DeliveryProduct> products;

  CheckoutDeliveryOrderParams({
    required this.shippingUserAddressId,
    required this.billingUserAddressId,
    required this.isShippingSameAsBilling,
    required this.products,
  });

  factory CheckoutDeliveryOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDeliveryOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutDeliveryOrderParamsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeliveryProduct {
  final String sku;
  final int quantity;

  DeliveryProduct({
    required this.sku,
    required this.quantity,
  });

  factory DeliveryProduct.fromJson(Map<String, dynamic> json) =>
      _$DeliveryProductFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryProductToJson(this);
}
