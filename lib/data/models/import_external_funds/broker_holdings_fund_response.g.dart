// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broker_holdings_fund_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrokerHoldingsFund _$BrokerHoldingsFundFromJson(Map<String, dynamic> json) =>
    BrokerHoldingsFund(
      id: json['id'] as int,
      userID: json['userID'] as int,
      schemeName: json['schemeName'] as String?,
      schemeCode: json['schemeCode'] as String?,
      amc: json['amc'] as String?,
      amcCode: json['amcCode'] as String?,
      nav: (json['nav'] as num?)?.toDouble(),
      brokerName: json['brokerName'] as String?,
      folioNumber: json['folioNumber'] as String?,
      brokerCode: json['brokerCode'] as String?,
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      amcLogo: json['amcLogo'] as String?,
      currentReturns: (json['currentReturns'] as num?)?.toDouble(),
      returnsPercentage: (json['returnsPercentage'] as num?)?.toDouble(),
      averagePrice: (json['averagePrice'] as num?)?.toDouble(),
      realisedReturns: (json['realisedReturns'] as num?)?.toDouble(),
      oneDayChange: (json['oneDayChange'] as num?)?.toDouble(),
      oneDayChangePercentage:
          (json['oneDayChangePercentage'] as num?)?.toDouble(),
      xirr: (json['xirr'] as num?)?.toDouble(),
      lastImport: json['lastImport'] as int,
    );

Map<String, dynamic> _$BrokerHoldingsFundToJson(BrokerHoldingsFund instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'schemeName': instance.schemeName,
      'schemeCode': instance.schemeCode,
      'amc': instance.amc,
      'amcCode': instance.amcCode,
      'nav': instance.nav,
      'brokerName': instance.brokerName,
      'folioNumber': instance.folioNumber,
      'brokerCode': instance.brokerCode,
      'currentValue': instance.currentValue,
      'investedValue': instance.investedValue,
      'amcLogo': instance.amcLogo,
      'currentReturns': instance.currentReturns,
      'returnsPercentage': instance.returnsPercentage,
      'averagePrice': instance.averagePrice,
      'realisedReturns': instance.realisedReturns,
      'oneDayChange': instance.oneDayChange,
      'oneDayChangePercentage': instance.oneDayChangePercentage,
      'xirr': instance.xirr,
      'lastImport': instance.lastImport,
    };
