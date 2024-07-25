// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_mandate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserMandateParams _$AddUserMandateParamsFromJson(
        Map<String, dynamic> json) =>
    AddUserMandateParams(
      limit: (json['limit'] as num).toDouble(),
      bankId: json['bankId'] as int,
      isWeb: json['isWeb'] as bool? ?? false,
    );

Map<String, dynamic> _$AddUserMandateParamsToJson(
        AddUserMandateParams instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'bankId': instance.bankId,
      'isWeb': instance.isWeb,
    };
