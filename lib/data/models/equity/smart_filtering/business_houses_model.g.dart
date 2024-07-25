// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_houses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessHouseModel _$BusinessHouseModelFromJson(Map<String, dynamic> json) =>
    BusinessHouseModel(
      businessHouseEnum: json['businessHouseEnum'] as String?,
      businessHouse: json['businessHouse'] as String?,
      count: json['count'] as int?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$BusinessHouseModelToJson(BusinessHouseModel instance) =>
    <String, dynamic>{
      'businessHouseEnum': instance.businessHouseEnum,
      'businessHouse': instance.businessHouse,
      'count': instance.count,
      'icon': instance.icon,
    };
