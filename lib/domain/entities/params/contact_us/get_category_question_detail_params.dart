import 'package:json_annotation/json_annotation.dart';

part 'get_category_question_detail_params.g.dart';

@JsonSerializable()
class GetCategoryQuestionDetailParams {
  final String id;
  GetCategoryQuestionDetailParams({
    required this.id,
  });

  factory GetCategoryQuestionDetailParams.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryQuestionDetailParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCategoryQuestionDetailParamsToJson(this);
}
