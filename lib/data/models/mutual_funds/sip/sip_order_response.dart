import 'package:json_annotation/json_annotation.dart';

import '../amc_logo.dart';

part 'sip_order_response.g.dart';

@JsonSerializable()
class SipOrderResponse {
  @JsonKey(name: 'tokenUrl')
  final String paymentUrl;
  @JsonKey(name: 'id')
  final int paymentId;
  final AmcLogo amcLogo;
  final String planName;
  final double amount;
  final String type;
  final String? folioNumber;
  final int startDay;

  SipOrderResponse({
    required this.paymentUrl,
    required this.paymentId,
    required this.amcLogo,
    required this.planName,
    required this.amount,
    required this.type,
    required this.startDay,
    this.folioNumber,
  });

  factory SipOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$SipOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SipOrderResponseToJson(this);
}
