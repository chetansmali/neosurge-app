// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwitchOrderResponse _$SwitchOrderResponseFromJson(Map<String, dynamic> json) =>
    SwitchOrderResponse(
      id: json['id'] as int,
      switchId: json['switchId'] as int?,
      state: json['state'] as String?,
      status: json['status'] as String,
      amount: (json['amount'] as num).toDouble(),
      folioNumber: json['folioNumber'] as String,
      schemeInFundPlanId: json['schemeInFundPlanId'] as String,
      schemeOutFundPlanId: json['schemeOutFundPlanId'] as String,
      switchInSchemeName: json['switchInSchemeName'] as String,
      switchOutSchemeName: json['switchOutSchemeName'] as String,
      switchInImgUrl: json['switchInImgUrl'] as String,
      switchOutImgUrl: json['switchOutImgUrl'] as String,
      schemeInIsin: json['schemeInIsin'] as String,
      schemeOutIsin: json['schemeOutIsin'] as String,
      units: (json['units'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SwitchOrderResponseToJson(
        SwitchOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'switchId': instance.switchId,
      'state': instance.state,
      'status': instance.status,
      'amount': instance.amount,
      'folioNumber': instance.folioNumber,
      'schemeInFundPlanId': instance.schemeInFundPlanId,
      'schemeOutFundPlanId': instance.schemeOutFundPlanId,
      'switchInSchemeName': instance.switchInSchemeName,
      'switchOutSchemeName': instance.switchOutSchemeName,
      'switchInImgUrl': instance.switchInImgUrl,
      'switchOutImgUrl': instance.switchOutImgUrl,
      'schemeInIsin': instance.schemeInIsin,
      'schemeOutIsin': instance.schemeOutIsin,
      'units': instance.units,
    };
