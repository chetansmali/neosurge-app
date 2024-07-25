import 'package:json_annotation/json_annotation.dart';

part 'get_holdings_token_params.g.dart';

@JsonSerializable()
class EquityHoldingsTokenParams {
  final String smallcaseAuthToken;

  EquityHoldingsTokenParams({required this.smallcaseAuthToken});

  factory EquityHoldingsTokenParams.fromJson(Map<String, dynamic> json) =>
      _$EquityHoldingsTokenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EquityHoldingsTokenParamsToJson(this);
}
