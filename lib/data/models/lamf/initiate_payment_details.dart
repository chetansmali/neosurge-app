import 'package:json_annotation/json_annotation.dart';

part 'initiate_payment_details.g.dart';

@JsonSerializable()
class InitiatePaymentDetails {
  final String interactionToken;
  InitiatePaymentDetails(this.interactionToken);

  factory InitiatePaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$InitiatePaymentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$InitiatePaymentDetailsToJson(this);
}
