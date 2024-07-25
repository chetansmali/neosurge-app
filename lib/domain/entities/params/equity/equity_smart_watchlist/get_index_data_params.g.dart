// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_index_data_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIndexDataParams _$GetIndexDataParamsFromJson(Map<String, dynamic> json) =>
    GetIndexDataParams(
      indexes:
          (json['indexes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetIndexDataParamsToJson(GetIndexDataParams instance) =>
    <String, dynamic>{
      'indexes': instance.indexes,
    };
