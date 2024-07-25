import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'create_order_params.g.dart';

@JsonSerializable()
class CreateOrderParams {
  final MetalType metalType;
  final double amount;
  final String blockId;
  final double lockPrice;
  @JsonKey(name: 'type')
  final DGTransactionType transactionType;
  final double metalWeight;

  CreateOrderParams({
    required this.metalType,
    required this.amount,
    required this.blockId,
    required this.lockPrice,
    required this.transactionType,
    required this.metalWeight,
  });

  factory CreateOrderParams.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderParamsToJson(this);
}
