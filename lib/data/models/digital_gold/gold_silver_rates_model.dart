import 'package:json_annotation/json_annotation.dart';

part 'gold_silver_rates_model.g.dart';

@JsonSerializable()
class GoldSilverRatesModel {
  final int id;
  final String blockId;
  final double goldBuyRate;
  final double goldSellRate;
  final double silverBuyRate;
  final double silverSellRate;
  final double cgstPercentage;
  final double sgstPercentage;
  final double igstPercentage;

  GoldSilverRatesModel({
    required this.id,
    required this.blockId,
    required this.goldBuyRate,
    required this.goldSellRate,
    required this.silverBuyRate,
    required this.silverSellRate,
    required this.cgstPercentage,
    required this.sgstPercentage,
    required this.igstPercentage,
  });

  factory GoldSilverRatesModel.fromJson(Map<String, dynamic> json) =>
      _$GoldSilverRatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoldSilverRatesModelToJson(this);
}
