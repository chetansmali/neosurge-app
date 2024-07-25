import 'package:json_annotation/json_annotation.dart';

part 'investment_returns.g.dart';

@JsonSerializable()
class InvestmentReturns {
  //{
  //         "investedAmount": 775901,
  //         "currentValue": 777761.09,
  //         "unrealizedGain": 1860.09,
  //         "absoluteReturn": 0.24,
  //         "xirr": 10.7937816576
  //     }

  final double investedAmount;
  final double currentValue;
  final double unrealizedGain;
  final double absoluteReturn;
  final double xirr;

  double get totalReturns => currentValue - investedAmount;

  //set to 0 if investedAmount is 0
  double get percentageTotalReturns =>
      (investedAmount == 0 ? 0 : (totalReturns / investedAmount)) * 100;

  InvestmentReturns({
    required this.investedAmount,
    required this.currentValue,
    required this.unrealizedGain,
    required this.absoluteReturn,
    required this.xirr,
  });

  factory InvestmentReturns.fromJson(Map<String, dynamic> json) =>
      _$InvestmentReturnsFromJson(json);

  Map<String, dynamic> toJson() => _$InvestmentReturnsToJson(this);
}
