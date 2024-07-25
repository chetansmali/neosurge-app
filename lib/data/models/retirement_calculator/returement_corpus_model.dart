import 'package:json_annotation/json_annotation.dart';
part 'returement_corpus_model.g.dart';

@JsonSerializable()
class RetirementCorpusModel {
  final double? requiredCorpus;
  final double? monthlySavings;
  final double? goalForTheYear;

  RetirementCorpusModel({
    required this.requiredCorpus,
    required this.monthlySavings,
    required this.goalForTheYear,
  });
  factory RetirementCorpusModel.fromJson(Map<String, dynamic> json) =>
      _$RetirementCorpusModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetirementCorpusModelToJson(this);
}
