import 'package:json_annotation/json_annotation.dart';

part 'get_mutual_fund_by_isin_params.g.dart';

@JsonSerializable()
class GetMutualFundByIsinParams {
  GetMutualFundByIsinParams({required this.isin});

  final String isin;

  factory GetMutualFundByIsinParams.fromJson(Map<String, dynamic> json) =>
      _$GetMutualFundByIsinParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMutualFundByIsinParamsToJson(this);
}
