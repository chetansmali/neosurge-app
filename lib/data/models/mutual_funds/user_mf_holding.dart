import 'package:json_annotation/json_annotation.dart';

import 'user_mf_scheme.dart';

part 'user_mf_holding.g.dart';

@JsonSerializable()
class UserMfHoldings {
  final double investedValue;
  final double currentValue;
  final double totalReturns;
  final double returnsPercentage;

  final List<UserMfScheme> schemes;

  UserMfHoldings({
    required this.investedValue,
    required this.currentValue,
    required this.totalReturns,
    required this.returnsPercentage,
    required this.schemes,
  });

  UserMfHoldings copyWith({List<UserMfScheme>? schemes}) => UserMfHoldings(
        investedValue: investedValue,
        currentValue: currentValue,
        totalReturns: totalReturns,
        returnsPercentage: returnsPercentage,
        schemes: schemes ?? this.schemes,
      );

  factory UserMfHoldings.fromJson(Map<String, dynamic> json) =>
      _$UserMfHoldingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserMfHoldingsToJson(this);
}
