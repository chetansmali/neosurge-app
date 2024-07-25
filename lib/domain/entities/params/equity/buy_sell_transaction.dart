
import 'package:json_annotation/json_annotation.dart';
part 'buy_sell_transaction.g.dart';

@JsonSerializable()
class BuySellTransactionParams{
  final String smallcaseAuthToken;
  final String email;
  final OrderConfig orderConfig;

  BuySellTransactionParams({
    required this.smallcaseAuthToken,
    required this.email,
    required this.orderConfig
});
  factory BuySellTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$BuySellTransactionParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$BuySellTransactionParamsToJson(this);

}

@JsonSerializable()
class OrderConfig {
  final String type;
  final List<Security> securities;

  OrderConfig({
    required this.type,
    required this.securities,
  });
  factory OrderConfig.fromJson(Map<String, dynamic> json) =>
      _$OrderConfigFromJson(json);

  Map<String,dynamic> toJson() =>
      _$OrderConfigToJson(this);
}

@JsonSerializable()
class Security {
  final String ticker;
  final String type;
  final int quantity;

  Security({
    required this.ticker,
    required this.type,
    required this.quantity,
  });
  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);

  Map<String,dynamic> toJson() =>
      _$SecurityToJson(this);
}
