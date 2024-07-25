import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';
import '../user/address_details_model.dart';
import 'delivery_product_model.dart';

part 'dg_delivery_transaction_response_model.g.dart';

@JsonSerializable()
class DgDeliveryTransactionResponseModel {
  final int id;
  final DeliveryAddressDetailsModel billingUserAddressDetail;
  final DeliveryAddressDetailsModel shippingUserAddressDetail;
  final List<DeliveryGoldSilverProduct> deliveryGoldSilverProduct;
  final String transactionId;
  final String merchantTransactionId;
  final double shippingCharges;
  final double totalAmountPaid;
  final double totalWeight;
  final bool isGoldExist;
  final bool isSilverExist;
  final String? modeOfPayment;
  final DgTransactionStatus status;
  final String augmontStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  DgDeliveryTransactionResponseModel({
    required this.id,
    required this.billingUserAddressDetail,
    required this.shippingUserAddressDetail,
    required this.deliveryGoldSilverProduct,
    required this.transactionId,
    required this.merchantTransactionId,
    required this.shippingCharges,
    required this.totalAmountPaid,
    required this.totalWeight,
    required this.isGoldExist,
    required this.isSilverExist,
    this.modeOfPayment,
    required this.status,
    required this.augmontStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DgDeliveryTransactionResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$DgDeliveryTransactionResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DgDeliveryTransactionResponseModelToJson(this);
}

@JsonSerializable()
class DeliveryGoldSilverProduct {
  final int id;
  final DeliveryProductModel sku;
  final int quantity;
  final double totalAmount;

  DeliveryGoldSilverProduct({
    required this.id,
    required this.sku,
    required this.quantity,
    required this.totalAmount,
  });

  factory DeliveryGoldSilverProduct.fromJson(Map<String, dynamic> json) =>
      _$DeliveryGoldSilverProductFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryGoldSilverProductToJson(this);
}
