import 'package:json_annotation/json_annotation.dart';

part 'get_swp_installment_params.g.dart';

@JsonSerializable()
class GetSwpInstallmentParams {
  final int userId;
  @JsonKey(name: 'mf_redemption_plan')
  final String swpId;

  GetSwpInstallmentParams({
    required this.userId,
    required this.swpId,
  });

  factory GetSwpInstallmentParams.fromJson(Map<String, dynamic> json) =>
      _$GetSwpInstallmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSwpInstallmentParamsToJson(this);
}
