import 'package:json_annotation/json_annotation.dart';
part 'generate_capital_gain_file.g.dart';

@JsonSerializable()
class GenerateCapitalGainFileParams {
  final String financialYear;

  GenerateCapitalGainFileParams({
    required this.financialYear,
  });

  factory GenerateCapitalGainFileParams.fromJson(Map<String, dynamic> json) =>
      _$GenerateCapitalGainFileParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateCapitalGainFileParamsToJson(this);
}
