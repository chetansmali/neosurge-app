// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_goal_investment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGoalInvestmentParams _$CreateGoalInvestmentParamsFromJson(
        Map<String, dynamic> json) =>
    CreateGoalInvestmentParams(
      userId: json['userId'] as int,
      paymentId: json['paymentId'] as int,
      goalId: json['goalId'] as int,
    );

Map<String, dynamic> _$CreateGoalInvestmentParamsToJson(
        CreateGoalInvestmentParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'paymentId': instance.paymentId,
      'goalId': instance.goalId,
    };
