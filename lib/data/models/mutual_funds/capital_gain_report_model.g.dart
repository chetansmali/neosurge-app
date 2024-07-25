// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capital_gain_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapitalGainReportModel _$CapitalGainReportModelFromJson(
        Map<String, dynamic> json) =>
    CapitalGainReportModel(
      userId: json['userId'] as int,
      financialYear: json['financialYear'] as String,
      shortTermGains:
          TermGains.fromJson(json['shortTermGains'] as Map<String, dynamic>),
      longTermGains:
          TermGains.fromJson(json['longTermGains'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CapitalGainReportModelToJson(
        CapitalGainReportModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'financialYear': instance.financialYear,
      'shortTermGains': instance.shortTermGains,
      'longTermGains': instance.longTermGains,
    };

TermGains _$TermGainsFromJson(Map<String, dynamic> json) => TermGains(
      capitalGains: (json['capitalGains'] as num?)?.toDouble(),
      absoluteGains: (json['absoluteGains'] as num?)?.toDouble(),
      taxableGains: (json['taxableGains'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TermGainsToJson(TermGains instance) => <String, dynamic>{
      'capitalGains': instance.capitalGains,
      'absoluteGains': instance.absoluteGains,
      'taxableGains': instance.taxableGains,
    };
