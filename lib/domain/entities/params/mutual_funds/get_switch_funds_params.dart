import 'package:json_annotation/json_annotation.dart';

part 'get_switch_funds_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetSwitchFundsParams {
  final String amcCode;
  final String schemeCode;
  final double switchAmount;

  GetSwitchFundsParams({
    required this.amcCode,
    required this.schemeCode,
    required this.switchAmount,
  });

  factory GetSwitchFundsParams.fromJson(Map<String, dynamic> json) =>
      _$GetSwitchFundsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSwitchFundsParamsToJson(this);
}
