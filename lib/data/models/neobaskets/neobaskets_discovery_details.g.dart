// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neobaskets_discovery_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeobasketsDiscoveryDetails _$NeobasketsDiscoveryDetailsFromJson(
        Map<String, dynamic> json) =>
    NeobasketsDiscoveryDetails(
      basketID: json['basketID'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageURL: json['imageURL'] as String?,
      cagr: (json['cagr'] as num?)?.toDouble(),
      minSIP: (json['minSIP'] as num?)?.toDouble(),
      aum: (json['aum'] as num?)?.toDouble(),
      isThreeYearReturns: json['isThreeYearReturns'] as bool?,
    );

Map<String, dynamic> _$NeobasketsDiscoveryDetailsToJson(
        NeobasketsDiscoveryDetails instance) =>
    <String, dynamic>{
      'basketID': instance.basketID,
      'name': instance.name,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'cagr': instance.cagr,
      'minSIP': instance.minSIP,
      'aum': instance.aum,
      'isThreeYearReturns': instance.isThreeYearReturns,
    };
