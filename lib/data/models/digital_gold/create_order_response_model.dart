import 'package:json_annotation/json_annotation.dart';

part 'create_order_response_model.g.dart';

@JsonSerializable()
class CreateOrderResponseModel {
  // "key": "rzp_test_oDw757e5auoleh",
  //         "amount": "20000",
  //         "orderId": "order_Ig1fBdToUDz6Y6",
  //         "name": "Sajan B",
  //         "description": "Delivery Gold",
  //         "contact": null,
  //         "email": "sajan.bappal@mindstack.in"

  final String key;
  final String amount;
  final String orderId;
  final String name;
  final String description;
  final String? contact;
  final String email;

  CreateOrderResponseModel({
    required this.key,
    required this.amount,
    required this.orderId,
    required this.name,
    required this.description,
    this.contact,
    required this.email,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderResponseModelToJson(this);
}
