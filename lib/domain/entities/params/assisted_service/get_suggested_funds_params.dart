import 'package:json_annotation/json_annotation.dart';

part 'get_suggested_funds_params.g.dart';

@JsonSerializable()
class GetSuggestedFundsParams {
  final double amount;
  final int tenure;
  final int userId;

  /// this is used to get more fund suggestions. default is 0 and increments as user requests for
  /// more fund suggestions.
  final int suggestCount;

  GetSuggestedFundsParams({
    required this.amount,
    required this.tenure,
    required this.userId,
    this.suggestCount = 0,
  });

  factory GetSuggestedFundsParams.fromJson(Map<String, dynamic> json) =>
      _$GetSuggestedFundsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSuggestedFundsParamsToJson(this);
}
