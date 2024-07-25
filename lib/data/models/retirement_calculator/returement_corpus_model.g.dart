// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returement_corpus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirementCorpusModel _$RetirementCorpusModelFromJson(
        Map<String, dynamic> json) =>
    RetirementCorpusModel(
      requiredCorpus: (json['requiredCorpus'] as num?)?.toDouble(),
      monthlySavings: (json['monthlySavings'] as num?)?.toDouble(),
      goalForTheYear: (json['goalForTheYear'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RetirementCorpusModelToJson(
        RetirementCorpusModel instance) =>
    <String, dynamic>{
      'requiredCorpus': instance.requiredCorpus,
      'monthlySavings': instance.monthlySavings,
      'goalForTheYear': instance.goalForTheYear,
    };
