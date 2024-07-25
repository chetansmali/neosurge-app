import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'checkout_rates_params.g.dart';

@JsonSerializable()
class CheckoutRatesParams {
  ///Could be either amount in rupee or gms of metal in gms
  final double weight;
  @JsonKey(name: 'type')
  final DGTransactionType transactionType;
  final MetalType metalType;
  final GoldSilverUnitType unit;

  CheckoutRatesParams({
    required this.weight,
    required this.transactionType,
    required this.metalType,
    required this.unit,
  });

  factory CheckoutRatesParams.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRatesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRatesParamsToJson(this);
}
