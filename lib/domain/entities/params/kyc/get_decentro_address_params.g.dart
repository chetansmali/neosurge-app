// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_decentro_address_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDecentroAddressParams _$GetDecentroAddressParamsFromJson(
        Map<String, dynamic> json) =>
    GetDecentroAddressParams(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      documentType: json['document_type'] as String,
      idValue: json['id_value'] as String,
    );

Map<String, dynamic> _$GetDecentroAddressParamsToJson(
        GetDecentroAddressParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'document_type': instance.documentType,
      'id_value': instance.idValue,
    };
