// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sector_industries_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSectorIndustriesDetails _$GetSectorIndustriesDetailsFromJson(
        Map<String, dynamic> json) =>
    GetSectorIndustriesDetails(
      sector: json['sector'] as String,
      industries: (json['industries'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetSectorIndustriesDetailsToJson(
        GetSectorIndustriesDetails instance) =>
    <String, dynamic>{
      'sector': instance.sector,
      'industries': instance.industries,
    };
