// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retirement_inflation_calculator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirementInflationCalculatorModel _$RetirementInflationCalculatorModelFromJson(
        Map<String, dynamic> json) =>
    RetirementInflationCalculatorModel(
      monthlyExpenseInNYears:
          (json['monthlyExpenseInNYears'] as num?)?.toDouble(),
      retirementAge: (json['retirementAge'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RetirementInflationCalculatorModelToJson(
        RetirementInflationCalculatorModel instance) =>
    <String, dynamic>{
      'monthlyExpenseInNYears': instance.monthlyExpenseInNYears,
      'retirementAge': instance.retirementAge,
    };
