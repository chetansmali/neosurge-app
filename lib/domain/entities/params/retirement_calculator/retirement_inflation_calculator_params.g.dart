// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retirement_inflation_calculator_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirementInflationCalculatorParams
    _$RetirementInflationCalculatorParamsFromJson(Map<String, dynamic> json) =>
        RetirementInflationCalculatorParams(
          currentExpense: json['currentExpense'] as int,
          retirementAge: json['retirementAge'] as int,
          inflation: json['inflation'] as int,
        );

Map<String, dynamic> _$RetirementInflationCalculatorParamsToJson(
        RetirementInflationCalculatorParams instance) =>
    <String, dynamic>{
      'currentExpense': instance.currentExpense,
      'retirementAge': instance.retirementAge,
      'inflation': instance.inflation,
    };
