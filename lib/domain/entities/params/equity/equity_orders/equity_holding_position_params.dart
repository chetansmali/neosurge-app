import 'package:json_annotation/json_annotation.dart';

part 'equity_holding_position_params.g.dart';

@JsonSerializable(includeIfNull: false)
class EquityHoldingPortfolioParams {
  final String? instrumentType;

  EquityHoldingPortfolioParams({
    required this.instrumentType,
  });

  factory EquityHoldingPortfolioParams.fromJson(Map<String, dynamic> json) =>
      _$EquityHoldingPortfolioParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EquityHoldingPortfolioParamsToJson(this);
}
