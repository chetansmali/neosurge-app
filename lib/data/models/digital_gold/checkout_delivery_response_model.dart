import 'package:json_annotation/json_annotation.dart';

import '../user/address_details_model.dart';

part 'checkout_delivery_response_model.g.dart';

@JsonSerializable()
class CheckoutDeliveryResponseModel {
  final DeliveryAddressDetailsModel billingUserAddressDetail;
  final DeliveryAddressDetailsModel shippingUserAddressDetail;
  final double quantity;
  final double amount;
  final double tax;
  final double totalAmount;
  final double paidfromWallet;
  final double amountPayable;

  CheckoutDeliveryResponseModel({
    required this.billingUserAddressDetail,
    required this.shippingUserAddressDetail,
    required this.quantity,
    required this.amount,
    required this.tax,
    required this.totalAmount,
    required this.paidfromWallet,
    required this.amountPayable,
  });

  factory CheckoutDeliveryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDeliveryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutDeliveryResponseModelToJson(this);
}
