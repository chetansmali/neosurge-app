// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_mandate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteMandateModel _$DeleteMandateModelFromJson(Map<String, dynamic> json) =>
    DeleteMandateModel(
      status: json['status'] as String,
      deleteId: json['deleteID'] as String,
    );

Map<String, dynamic> _$DeleteMandateModelToJson(DeleteMandateModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'deleteID': instance.deleteId,
    };
