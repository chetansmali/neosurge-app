// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetails _$NewsDetailsFromJson(Map<String, dynamic> json) => NewsDetails(
      errorCode: json['errorCode'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsDetailsToJson(NewsDetails instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'data': instance.data,
    };
