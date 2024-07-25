import 'package:json_annotation/json_annotation.dart';

part 'get_category_questions_params.g.dart';

@JsonSerializable()
class GetCategoryQuestionsParams {
  final String? page;
  final String? size;
  final String? sort;
  final String? query;
  final String? category;
  GetCategoryQuestionsParams({
    this.page,
    this.size,
    this.sort,
    this.query,
    this.category,
  });

  factory GetCategoryQuestionsParams.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryQuestionsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoryQuestionsParamsToJson(this);
}
