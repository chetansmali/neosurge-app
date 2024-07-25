// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_goal_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGoalDetailsModel _$GetGoalDetailsModelFromJson(Map<String, dynamic> json) =>
    GetGoalDetailsModel(
      goalName: json['goalName'] as String?,
      goalType: json['goalType'] as String?,
      goalIcon: json['goalIcon'] as String?,
      goalCompleted: json['goalCompleted'] as bool?,
      currentGoalValue: (json['currentGoalValue'] as num?)?.toDouble(),
      targetGoalValue: (json['targetGoalValue'] as num?)?.toDouble(),
      goalInvestedValue: (json['goalInvestedValue'] as num?)?.toDouble(),
      linkedInvestments: (json['linkedInvestments'] as List<dynamic>?)
          ?.map((e) => LinkedInvestments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGoalDetailsModelToJson(
        GetGoalDetailsModel instance) =>
    <String, dynamic>{
      'goalName': instance.goalName,
      'goalType': instance.goalType,
      'goalIcon': instance.goalIcon,
      'goalCompleted': instance.goalCompleted,
      'currentGoalValue': instance.currentGoalValue,
      'targetGoalValue': instance.targetGoalValue,
      'goalInvestedValue': instance.goalInvestedValue,
      'linkedInvestments': instance.linkedInvestments,
    };

LinkedInvestments _$LinkedInvestmentsFromJson(Map<String, dynamic> json) =>
    LinkedInvestments(
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      schemeName: json['schemeName'] as String?,
      amcLogo: json['amcLogo'] as String?,
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      returnsPercentage: (json['returnsPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LinkedInvestmentsToJson(LinkedInvestments instance) =>
    <String, dynamic>{
      'schemeName': instance.schemeName,
      'amcLogo': instance.amcLogo,
      'investedValue': instance.investedValue,
      'currentValue': instance.currentValue,
      'returnsPercentage': instance.returnsPercentage,
    };
