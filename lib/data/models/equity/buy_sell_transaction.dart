import 'package:json_annotation/json_annotation.dart';
part 'buy_sell_transaction.g.dart';
@JsonSerializable()
class BuySellTransationModel{
  final String transactionId;
  final bool success;

  BuySellTransationModel({
    required this.transactionId,
    required this.success,
});

  factory BuySellTransationModel.fromJson(Map<String, dynamic> json) =>
      _$BuySellTransationModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$BuySellTransationModelToJson(this);
}