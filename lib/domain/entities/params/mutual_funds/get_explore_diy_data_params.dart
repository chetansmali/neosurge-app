import 'package:json_annotation/json_annotation.dart';

part 'get_explore_diy_data_params.g.dart';

@JsonSerializable()
class GetExploreDIYDataParams {
  final String assetcategory;

  GetExploreDIYDataParams({
    required this.assetcategory,
  });

  factory GetExploreDIYDataParams.fromJson(Map<String, dynamic> json) =>
      _$GetExploreDIYDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetExploreDIYDataParamsToJson(this);
}
