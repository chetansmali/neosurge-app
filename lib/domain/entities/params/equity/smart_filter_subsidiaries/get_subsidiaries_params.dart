import 'package:json_annotation/json_annotation.dart';
part 'get_subsidiaries_params.g.dart';

@JsonSerializable(includeIfNull: false)
class GetSubsidiariesParams {
  final String businessHouse;
  final int? page;
  final int? size;
  final String? sort;

  GetSubsidiariesParams({
    required this.businessHouse,
    required this.page,
    required this.size,
    required this.sort,
  });

  factory GetSubsidiariesParams.fromJson(Map<String, dynamic> json) =>
      _$GetSubsidiariesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSubsidiariesParamsToJson(this);
}
