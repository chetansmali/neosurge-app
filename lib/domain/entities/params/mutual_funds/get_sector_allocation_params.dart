import 'package:json_annotation/json_annotation.dart';

part 'get_sector_allocation_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetSectorAllocationParams {
  //{
  // 	"scheme_code": "100851",
  //     "as_on": "",
  //     "portfolio_type":""
  // }
  final String schemeCode;

  ///as on date in the format mm-yyyy(eg. 01-2020)
  final String? asOn;
  final String? portfolioType;

  GetSectorAllocationParams({
    required this.schemeCode,
    this.asOn,
    this.portfolioType,
  });

  Map<String, dynamic> toJson() => _$GetSectorAllocationParamsToJson(this);

  factory GetSectorAllocationParams.fromJson(Map<String, dynamic> json) =>
      _$GetSectorAllocationParamsFromJson(json);
}
