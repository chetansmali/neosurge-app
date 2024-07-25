import 'package:json_annotation/json_annotation.dart';

import 'checkout_delivery_order_params.dart';
import 'post_payment_params.dart';

part 'post_payment_delivery_params.g.dart';

@JsonSerializable(explicitToJson: true)
class PostPaymentDeliveryParams extends PostPaymentParams {
  // "shippingUserAddressId":"Dqrao6XR",
//     "billingUserAddressId":"Dqrao6XR",
//     "isShippingSameAsBilling":true,

  final String shippingUserAddressId;
  final String billingUserAddressId;
  final bool isShippingSameAsBilling;
  @JsonKey(name: 'product')
  final List<DeliveryProduct> products;

  PostPaymentDeliveryParams(
      {required super.orderId,
      required super.paymentId,
      required super.status,
      required this.shippingUserAddressId,
      required this.billingUserAddressId,
      required this.isShippingSameAsBilling,
      required this.products});

  factory PostPaymentDeliveryParams.fromJson(Map<String, dynamic> json) =>
      _$PostPaymentDeliveryParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostPaymentDeliveryParamsToJson(this);
}
