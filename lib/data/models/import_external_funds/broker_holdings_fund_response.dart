import 'package:json_annotation/json_annotation.dart';
part 'broker_holdings_fund_response.g.dart';

@JsonSerializable()
class BrokerHoldingsFund {
  final int id;
  final int userID;
  final String? schemeName;
  final String? schemeCode;
  final String? amc;
  final String? amcCode;
  final double? nav;
  final String? brokerName;
  final String? folioNumber;
  final String? brokerCode;
  final double? currentValue;
  final double? investedValue;
  final String? amcLogo;
  final double? currentReturns;
  final double? returnsPercentage;
  final double? averagePrice;
  final double? realisedReturns;
  final double? oneDayChange;
  final double? oneDayChangePercentage;
  final double? xirr;
  final int lastImport;

  BrokerHoldingsFund({
    required this.id,
    required this.userID,
    required this.schemeName,
    required this.schemeCode,
    required this.amc,
    required this.amcCode,
    required this.nav,
    required this.brokerName,
    required this.folioNumber,
    required this.brokerCode,
    required this.currentValue,
    required this.investedValue,
    required this.amcLogo,
    required this.currentReturns,
    required this.returnsPercentage,
    required this.averagePrice,
    required this.realisedReturns,
    required this.oneDayChange,
    required this.oneDayChangePercentage,
    required this.xirr,
    required this.lastImport,
  });

  factory BrokerHoldingsFund.fromJson(Map<String, dynamic> json) =>
      _$BrokerHoldingsFundFromJson(json);

  Map<String, dynamic> toJson() => _$BrokerHoldingsFundToJson(this);
}
