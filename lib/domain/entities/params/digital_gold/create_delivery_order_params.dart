import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';
import 'checkout_delivery_order_params.dart';

part 'create_delivery_order_params.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateDeliveryOrderParams {
  final MetalType metalType;
  @JsonKey(name: 'type')
  final DGTransactionType transactionType;
  final String shippingUserAddressId;
  final String billingUserAddressId;
  final bool isShippingSameAsBilling;
  @JsonKey(name: 'product')
  final List<DeliveryProduct> products;

  CreateDeliveryOrderParams({
    required this.metalType,
    required this.transactionType,
    required this.shippingUserAddressId,
    required this.billingUserAddressId,
    required this.isShippingSameAsBilling,
    required this.products,
  });

  factory CreateDeliveryOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateDeliveryOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDeliveryOrderParamsToJson(this);
}
