import 'package:json_annotation/json_annotation.dart';

part 'get_sips_by_mandate_params.g.dart';

@JsonSerializable()
class GetSipsByMandateParams {
  @JsonKey(name: 'mandateID')
  final int mandateId;

  GetSipsByMandateParams({
    required this.mandateId,
  });

  factory GetSipsByMandateParams.fromJson(Map<String, dynamic> json) =>
      _$GetSipsByMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSipsByMandateParamsToJson(this);
}
