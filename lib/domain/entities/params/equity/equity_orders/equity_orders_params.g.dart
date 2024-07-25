// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equity_orders_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquityOrdersParams _$EquityOrdersParamsFromJson(Map<String, dynamic> json) =>
    EquityOrdersParams(
      email: json['email'] as String,
      timePeriod: json['timePeriod'] as String,
      status: json['status'] as String,
      instrumentType: json['instrumentType'] as String?,
    );

Map<String, dynamic> _$EquityOrdersParamsToJson(EquityOrdersParams instance) {
  final val = <String, dynamic>{
    'email': instance.email,
    'timePeriod': instance.timePeriod,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('instrumentType', instance.instrumentType);
  return val;
}
