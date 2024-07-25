// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveAlertModel _$RemoveAlertModelFromJson(Map<String, dynamic> json) =>
    RemoveAlertModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RemoveAlertModelToJson(RemoveAlertModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
