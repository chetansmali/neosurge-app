// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_alert_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsersAlertParams _$GetUsersAlertParamsFromJson(Map<String, dynamic> json) =>
    GetUsersAlertParams(
      page: json['page'] as int,
      size: json['size'] as int,
      sort: json['sort'] as String,
    );

Map<String, dynamic> _$GetUsersAlertParamsToJson(
        GetUsersAlertParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
