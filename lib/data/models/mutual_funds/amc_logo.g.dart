// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amc_logo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmcLogo _$AmcLogoFromJson(Map<String, dynamic> json) => AmcLogo(
      id: json['id'] as int,
      amcCode: json['amcCode'] as String,
      amcName: json['amcName'] as String,
      imgUrl: json['imgUrl'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AmcLogoToJson(AmcLogo instance) => <String, dynamic>{
      'id': instance.id,
      'amcCode': instance.amcCode,
      'amcName': instance.amcName,
      'imgUrl': instance.imgUrl,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
