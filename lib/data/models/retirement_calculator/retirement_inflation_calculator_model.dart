import 'package:json_annotation/json_annotation.dart';
part 'retirement_inflation_calculator_model.g.dart';

@JsonSerializable()
class RetirementInflationCalculatorModel {
  final double? monthlyExpenseInNYears;
  final double? retirementAge;

  RetirementInflationCalculatorModel({
    required this.monthlyExpenseInNYears,
    required this.retirementAge,
  });
  factory RetirementInflationCalculatorModel.fromJson(
          Map<String, dynamic> json) =>
      _$RetirementInflationCalculatorModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RetirementInflationCalculatorModelToJson(this);
}
