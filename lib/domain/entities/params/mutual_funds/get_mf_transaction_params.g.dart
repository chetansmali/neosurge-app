// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mf_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMfTransactionParams _$GetMfTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    GetMfTransactionParams(
      isin: json['isin'] as String,
      folio: json['folio'] as String,
    );

Map<String, dynamic> _$GetMfTransactionParamsToJson(
        GetMfTransactionParams instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'folio': instance.folio,
    };
