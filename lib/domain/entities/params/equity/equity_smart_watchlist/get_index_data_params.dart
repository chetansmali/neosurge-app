import 'package:json_annotation/json_annotation.dart';

part 'get_index_data_params.g.dart';

@JsonSerializable()
class GetIndexDataParams {
  List<String> indexes;
  GetIndexDataParams({required this.indexes});

  factory GetIndexDataParams.fromJson(Map<String, dynamic> json) =>
      _$GetIndexDataParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetIndexDataParamsToJson(this);
}
