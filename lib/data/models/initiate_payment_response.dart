import 'package:json_annotation/json_annotation.dart';

part 'initiate_payment_response.g.dart';

@JsonSerializable()
class InitiatePaymentResponse {
  final int id;
  @JsonKey(name: 'tokenUrl')
  final String paymentUrl;

  InitiatePaymentResponse({
    required this.id,
    required this.paymentUrl,
  });

  factory InitiatePaymentResponse.fromJson(
          Map<String, dynamic> json) =>
      _$InitiatePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InitiatePaymentResponseToJson(this);
}
