import 'package:json_annotation/json_annotation.dart';

part 'invest_suggested_funds_params.g.dart';

@JsonSerializable(explicitToJson: true)
class InvestSuggestedFundsParams {
  final int userId;
  final int mfLumpsumConsentId;
  final List<SuggestedFundDetail> suggestionList;

  InvestSuggestedFundsParams({
    required this.userId,
    required this.mfLumpsumConsentId,
    required this.suggestionList,
  });

  factory InvestSuggestedFundsParams.fromJson(Map<String, dynamic> json) =>
      _$InvestSuggestedFundsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InvestSuggestedFundsParamsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SuggestedFundDetail {
  final int id;
  final String fundId;
  final String name;
  final String type;
  final double amount;
  final bool isThematic;

  SuggestedFundDetail({
    required this.id,
    required this.amount,
    required this.fundId,
    required this.name,
    required this.type,
    required this.isThematic,
  });

  factory SuggestedFundDetail.fromJson(Map<String, dynamic> json) =>
      _$SuggestedFundDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedFundDetailToJson(this);
}
