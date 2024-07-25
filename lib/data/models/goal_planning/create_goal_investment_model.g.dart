// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_goal_investment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGoalInvestmentModel _$CreateGoalInvestmentModelFromJson(
        Map<String, dynamic> json) =>
    CreateGoalInvestmentModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as String,
    );

Map<String, dynamic> _$CreateGoalInvestmentModelToJson(
        CreateGoalInvestmentModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
