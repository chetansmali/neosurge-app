import 'package:json_annotation/json_annotation.dart';

part 'get_sip_installment_params.g.dart';

@JsonSerializable()
class GetSipInstallmentParams {
  final int userId;
  final int sipId;

  GetSipInstallmentParams({
    required this.userId,
    required this.sipId,
  });

  factory GetSipInstallmentParams.fromJson(Map<String, dynamic> json) =>
      _$GetSipInstallmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSipInstallmentParamsToJson(this);
}
