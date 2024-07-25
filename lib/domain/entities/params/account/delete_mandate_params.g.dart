// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_mandate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteMandateParams _$DeleteMandateParamsFromJson(Map<String, dynamic> json) =>
    DeleteMandateParams(
      closeAll: json['closeAll'] as bool?,
      mandateId: json['mandateID'] as int?,
      alternateId: json['alternateID'] as int?,
    );

Map<String, dynamic> _$DeleteMandateParamsToJson(
        DeleteMandateParams instance) =>
    <String, dynamic>{
      'closeAll': instance.closeAll,
      'mandateID': instance.mandateId,
      'alternateID': instance.alternateId,
    };
