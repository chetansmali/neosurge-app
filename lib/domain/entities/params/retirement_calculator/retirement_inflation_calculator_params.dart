import 'package:json_annotation/json_annotation.dart';
part 'retirement_inflation_calculator_params.g.dart';

@JsonSerializable()
class RetirementInflationCalculatorParams {
  final int currentExpense;
  final int retirementAge;
  final int inflation;

  RetirementInflationCalculatorParams({
    required this.currentExpense,
    required this.retirementAge,
    required this.inflation,
  });
  factory RetirementInflationCalculatorParams.fromJson(
          Map<String, dynamic> json) =>
      _$RetirementInflationCalculatorParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RetirementInflationCalculatorParamsToJson(this);
}
