import 'package:json_annotation/json_annotation.dart';
part 'capital_gain_report_model.g.dart';

@JsonSerializable()
class CapitalGainReportModel {
  final int userId;
  final String financialYear;
  final TermGains shortTermGains;
  final TermGains longTermGains;

  CapitalGainReportModel({
    required this.userId,
    required this.financialYear,
    required this.shortTermGains,
    required this.longTermGains,
  });

  factory CapitalGainReportModel.fromJson(Map<String, dynamic> json) =>
      _$CapitalGainReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$CapitalGainReportModelToJson(this);
}

@JsonSerializable()
class TermGains {
  final double? capitalGains;
  final double? absoluteGains;
  final double? taxableGains;

  TermGains({
    required this.capitalGains,
    required this.absoluteGains,
    required this.taxableGains,
  });

  factory TermGains.fromJson(Map<String, dynamic> json) =>
      _$TermGainsFromJson(json);

  Map<String, dynamic> toJson() => _$TermGainsToJson(this);
}
