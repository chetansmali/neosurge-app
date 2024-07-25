import 'package:json_annotation/json_annotation.dart';
part 'basket_transaction_detail_params.g.dart';

@JsonSerializable()
class BasketTransactionDetailParams {
  final String orderRef;

  BasketTransactionDetailParams({
    required this.orderRef,
  });

  factory BasketTransactionDetailParams.fromJson(Map<String, dynamic> json) =>
      _$BasketTransactionDetailParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BasketTransactionDetailParamsToJson(this);
}
