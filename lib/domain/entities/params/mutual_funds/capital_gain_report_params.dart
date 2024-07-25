import 'package:json_annotation/json_annotation.dart';
part 'capital_gain_report_params.g.dart';

@JsonSerializable()
class CapitalGainReportParams {
  final String financialYear;

  CapitalGainReportParams({
    required this.financialYear,
  });

  factory CapitalGainReportParams.fromJson(Map<String, dynamic> json) =>
      _$CapitalGainReportParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CapitalGainReportParamsToJson(this);
}
