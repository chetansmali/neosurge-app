import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'mf_order.g.dart';

@JsonSerializable()
class MfOrder {
// "orderType": "SIP",
// "fundName": "Axis Dynamic Bond Fund",
// "folioNumber": null,
// "isin": "INF846K01917",
// "amount": 6000.0,
// "units": null,
// "orderId": "181",
// "submittedAt": "2022-07-25 12:06:13.027",
// "createdAt": "2022-07-25T12:06:19.376+00:00",
// "investedDate": "2022-07-26 00:00:00.0",
// "status": "Pending",
// "mfOldId": 319

  final MFTransactionTypes orderType;
  final String? fundName;
  final String? folioNumber;
  final String isin;
  final double? amount;
  @JsonKey(defaultValue: 0.0)
  final double? units;
  final String? orderId;
  final DateTime? submittedAt;
  final DateTime createdAt;
  final DateTime? investedDate;
  final DateTime? succeededAt;
  final DateTime? failedAt;
  final MFOrderStatus status;
  final int? mfOldId;
  final String? inFundName;
  final String? outFundName;

  MfOrder({
    required this.orderType,
    required this.fundName,
    this.folioNumber,
    required this.isin,
    this.amount,
    this.units,
    this.orderId,
    this.submittedAt,
    required this.createdAt,
    this.investedDate,
    this.succeededAt,
    this.failedAt,
    required this.status,
    this.mfOldId,
    this.inFundName,
    this.outFundName,
  }) : assert(amount != null || units != null,
            'amount or units must be provided');

  factory MfOrder.fromJson(Map<String, dynamic> json) =>
      _$MfOrderFromJson(json);

  Map<String, dynamic> toJson() => _$MfOrderToJson(this);
}
