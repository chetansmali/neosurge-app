import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'mf_transaction.g.dart';

@JsonSerializable()
class MfTransaction {
  final double cagr;
  final double avgNav;
  final List<TransactionHistory> transactionHistory;

  MfTransaction({
    required this.cagr,
    required this.avgNav,
    required this.transactionHistory,
  });

  factory MfTransaction.fromJson(Map<String, dynamic> json) =>
      _$MfTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$MfTransactionToJson(this);
}

@JsonSerializable()
class TransactionHistory {
  // {
  //             "object": "transaction",
  //             "folioNumber": "8594681631608",
  //             "isin": "INF090I01DG6",
  //             "type": "purchase",
  //             "amount": 121212,
  //             "units": 1508.4412,
  //             "tradedOn": "2022-07-07",
  //             "tradedAt": 80.3558,
  //             "order": "197",
  //             "corporateAction": null,
  //             "relatedTransactionId": null,
  //             "rtaOrderReference": "197",
  //             "rtaProductCode": "FTI012",
  //             "rtaInvestmentOption": "GROWTH",
  //             "rtaSchemeName": "Franklin India Corporate Debt Fund - Plan A",
  //             "sources": []
  //         },
  final String object;
  final String folioNumber;
  final String isin;
  final FundTransactionTypeString type;
  final double amount;
  final double units;
  final DateTime tradedOn;
  final double tradedAt;
  final String order;
  final String? corporateAction;
  final String? relatedTransactionId;
  final String rtaOrderReference;
  final String rtaProductCode;
  final String rtaInvestmentOption;
  final String rtaSchemeName;
  final List<dynamic> sources;

  double get nav => (amount / units);

  TransactionHistory({
    required this.object,
    required this.folioNumber,
    required this.isin,
    required this.type,
    required this.amount,
    required this.units,
    required this.tradedOn,
    required this.tradedAt,
    required this.order,
    this.corporateAction,
    this.relatedTransactionId,
    required this.rtaOrderReference,
    required this.rtaProductCode,
    required this.rtaInvestmentOption,
    required this.rtaSchemeName,
    required this.sources,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryToJson(this);
}
