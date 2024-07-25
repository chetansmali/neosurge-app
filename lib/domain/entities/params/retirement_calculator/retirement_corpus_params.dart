import 'package:json_annotation/json_annotation.dart';
part 'retirement_corpus_params.g.dart';

@JsonSerializable()
class RetirementCorpusParams {
  final int monthlyIncome;
  final int monthlyExpense;
  final int existingSavings;
  final String investmentStyle;
  final String postRetirementStyle;
  final int retirementAge;

  RetirementCorpusParams({
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.existingSavings,
    required this.investmentStyle,
    required this.postRetirementStyle,
    required this.retirementAge,
  });
  factory RetirementCorpusParams.fromJson(Map<String, dynamic> json) =>
      _$RetirementCorpusParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RetirementCorpusParamsToJson(this);
}
