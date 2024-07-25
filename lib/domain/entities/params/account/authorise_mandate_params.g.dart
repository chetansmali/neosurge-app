// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorise_mandate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthoriseMandateParams _$AuthoriseMandateParamsFromJson(
        Map<String, dynamic> json) =>
    AuthoriseMandateParams(
      mandateId: json['mandateId'] as int,
      isWeb: json['isWeb'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthoriseMandateParamsToJson(
        AuthoriseMandateParams instance) =>
    <String, dynamic>{
      'mandateId': instance.mandateId,
      'isWeb': instance.isWeb,
    };
