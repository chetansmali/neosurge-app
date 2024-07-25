import 'package:json_annotation/json_annotation.dart';

part 'get_stp_installment_params.g.dart';

@JsonSerializable()
class GetStpInstallmentParams {
  final int userId;
  final String stpId;

  GetStpInstallmentParams({
    required this.userId,
    required this.stpId,
  });

  factory GetStpInstallmentParams.fromJson(Map<String, dynamic> json) =>
      _$GetStpInstallmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetStpInstallmentParamsToJson(this);
}
