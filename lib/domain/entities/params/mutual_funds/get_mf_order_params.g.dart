// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mf_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMfOrderParams _$GetMfOrderParamsFromJson(Map<String, dynamic> json) =>
    GetMfOrderParams(
      userId: json['userId'] as int,
      isAllOrders: json['isAllOrders'] as bool,
      status: $enumDecodeNullable(_$MFOrderStatusEnumMap, json['status']),
      limit: json['limit'] as int? ?? 10,
      from: json['from'] as int? ?? 1,
      isDiyOrder: json['isDiyOrder'] as bool? ?? false,
    );

Map<String, dynamic> _$GetMfOrderParamsToJson(GetMfOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isAllOrders': instance.isAllOrders,
      'status': _$MFOrderStatusEnumMap[instance.status],
      'limit': instance.limit,
      'from': instance.from,
      'isDiyOrder': instance.isDiyOrder,
    };

const _$MFOrderStatusEnumMap = {
  MFOrderStatus.pending: 'Pending',
  MFOrderStatus.success: 'Successful',
  MFOrderStatus.failed: 'Failed',
};
