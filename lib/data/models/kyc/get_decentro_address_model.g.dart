// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_decentro_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDecentroAddressModel _$GetDecentroAddressModelFromJson(
        Map<String, dynamic> json) =>
    GetDecentroAddressModel(
      sequence: json['sequence'] as String,
      reportedDate: json['reportedDate'] as String,
      address: json['address'] as String,
      state: json['state'] as String,
      type: json['type'] as String,
      postal: json['postal'] as String,
    );

Map<String, dynamic> _$GetDecentroAddressModelToJson(
        GetDecentroAddressModel instance) =>
    <String, dynamic>{
      'sequence': instance.sequence,
      'reportedDate': instance.reportedDate,
      'address': instance.address,
      'state': instance.state,
      'type': instance.type,
      'postal': instance.postal,
    };
