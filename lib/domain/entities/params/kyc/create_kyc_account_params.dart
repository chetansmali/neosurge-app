import 'package:json_annotation/json_annotation.dart';

part 'create_kyc_account_params.g.dart';

@JsonSerializable()
class CreateKycAccountParams {
  final int userId;

  CreateKycAccountParams({
    required this.userId,
  });

  factory CreateKycAccountParams.fromJson(Map<String, dynamic> json) =>
      _$CreateKycAccountParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKycAccountParamsToJson(this);
}
