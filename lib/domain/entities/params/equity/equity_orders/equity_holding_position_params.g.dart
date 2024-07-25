// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equity_holding_position_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquityHoldingPortfolioParams _$EquityHoldingPortfolioParamsFromJson(
        Map<String, dynamic> json) =>
    EquityHoldingPortfolioParams(
      instrumentType: json['instrumentType'] as String?,
    );

Map<String, dynamic> _$EquityHoldingPortfolioParamsToJson(
    EquityHoldingPortfolioParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('instrumentType', instance.instrumentType);
  return val;
}
