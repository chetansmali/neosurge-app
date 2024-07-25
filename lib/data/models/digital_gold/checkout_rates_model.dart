import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';
import 'gold_silver_rates_model.dart';

part 'checkout_rates_model.g.dart';

@JsonSerializable()
class CheckoutRatesModel {
  @JsonKey(name: 'type')
  final DGTransactionType transactionType;
  final MetalType metalType;
  final double metalWeight;
  final double taxAmount;
  final double metalAmount;
  final double totalAmount;
  final GoldSilverRatesModel goldSilverRate;

  double get lockPrice => transactionType == DGTransactionType.buy
      ? metalType == MetalType.gold
          ? goldSilverRate.goldBuyRate
          : goldSilverRate.silverBuyRate
      : metalType == MetalType.gold
          ? goldSilverRate.goldSellRate
          : goldSilverRate.silverSellRate;

  double get perGramBuyPrice => metalType == MetalType.gold
      ? goldSilverRate.goldBuyRate
      : goldSilverRate.silverBuyRate;

  double get perGramSellPrice => metalType == MetalType.gold
      ? goldSilverRate.goldSellRate
      : goldSilverRate.silverSellRate;

  double get transactionBasisPrice => transactionType == DGTransactionType.buy
      ? perGramBuyPrice
      : perGramSellPrice;

  CheckoutRatesModel({
    required this.transactionType,
    required this.metalType,
    required this.metalWeight,
    required this.taxAmount,
    required this.metalAmount,
    required this.totalAmount,
    required this.goldSilverRate,
  });

  factory CheckoutRatesModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRatesModelToJson(this);
}
