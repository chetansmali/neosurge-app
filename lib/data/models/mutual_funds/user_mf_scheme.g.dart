// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mf_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMfScheme _$UserMfSchemeFromJson(Map<String, dynamic> json) => UserMfScheme(
      isin: json['isin'] as String,
      folioNumber: json['folioNumber'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      holdingUnits: (json['holdingUnits'] as num).toDouble(),
      redeemableUnits: (json['redeemableUnits'] as num).toDouble(),
      investedAmount: (json['investedAmount'] as num).toDouble(),
      investedAsOn: json['investedAsOn'] as String,
      currentValue: (json['currentValue'] as num).toDouble(),
      redeemableAmount: (json['redeemableAmount'] as num).toDouble(),
      nav: (json['nav'] as num).toDouble(),
      gainOrLoss: (json['gainOrLoss'] as num).toDouble(),
      absoluteReturns: (json['absoluteReturns'] as num).toDouble(),
      navAsOn: DateTime.parse(json['navAsOn'] as String),
      avgNav: (json['avgNav'] as num).toDouble(),
      exitTriggerGenerated: json['exitTriggerGenerated'] as bool,
    );

Map<String, dynamic> _$UserMfSchemeToJson(UserMfScheme instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'folioNumber': instance.folioNumber,
      'name': instance.name,
      'type': instance.type,
      'holdingUnits': instance.holdingUnits,
      'redeemableUnits': instance.redeemableUnits,
      'investedAmount': instance.investedAmount,
      'investedAsOn': instance.investedAsOn,
      'currentValue': instance.currentValue,
      'redeemableAmount': instance.redeemableAmount,
      'nav': instance.nav,
      'gainOrLoss': instance.gainOrLoss,
      'absoluteReturns': instance.absoluteReturns,
      'navAsOn': instance.navAsOn.toIso8601String(),
      'avgNav': instance.avgNav,
      'exitTriggerGenerated': instance.exitTriggerGenerated,
    };
