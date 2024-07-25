// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_subsidiaries_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSubsidiariesParams _$GetSubsidiariesParamsFromJson(
        Map<String, dynamic> json) =>
    GetSubsidiariesParams(
      businessHouse: json['businessHouse'] as String,
      page: json['page'] as int?,
      size: json['size'] as int?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$GetSubsidiariesParamsToJson(
    GetSubsidiariesParams instance) {
  final val = <String, dynamic>{
    'businessHouse': instance.businessHouse,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('size', instance.size);
  writeNotNull('sort', instance.sort);
  return val;
}
