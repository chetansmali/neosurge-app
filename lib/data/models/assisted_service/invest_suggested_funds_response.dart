import 'package:json_annotation/json_annotation.dart';

part 'invest_suggested_funds_response.g.dart';

@JsonSerializable()
class InvestSuggestedFundsResponse {
  final List<int> ids;

  InvestSuggestedFundsResponse({
    required this.ids,
  });

  factory InvestSuggestedFundsResponse.fromJson(Map<String, dynamic> json) =>
      _$InvestSuggestedFundsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvestSuggestedFundsResponseToJson(this);
}
