import 'package:json_annotation/json_annotation.dart';

part 'get_stp_funds_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetStpFundsParams {
  final String amcCode;
  final String schemeCode;
  final double stpAmount;

  GetStpFundsParams({
    required this.amcCode,
    required this.schemeCode,
    required this.stpAmount,
  });

  Map<String, dynamic> toJson() => _$GetStpFundsParamsToJson(this);

  factory GetStpFundsParams.fromJson(Map<String, dynamic> json) =>
      _$GetStpFundsParamsFromJson(json);
}
