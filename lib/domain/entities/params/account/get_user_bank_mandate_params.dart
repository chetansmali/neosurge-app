import 'package:json_annotation/json_annotation.dart';

part 'get_user_bank_mandate_params.g.dart';

@JsonSerializable()
class GetUserBankMandateParams {
  @JsonKey(name: 'bankID')
  final int bankId;

  GetUserBankMandateParams({
    required this.bankId,
  });

  factory GetUserBankMandateParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserBankMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserBankMandateParamsToJson(this);
}
