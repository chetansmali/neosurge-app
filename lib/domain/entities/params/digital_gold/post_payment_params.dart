import 'package:json_annotation/json_annotation.dart';

part 'post_payment_params.g.dart';

@JsonSerializable()
class PostPaymentParams {
  //{
  //     "orderId":"order_JR2lq1ZjLPkjDU",
  //     "paymentId":"pay_IcSD9WHcCuq0Ex",
  //     "status":"success"
  // }

  final String orderId;
  final String paymentId;
  final String status;

  PostPaymentParams({
    required this.orderId,
    required this.paymentId,
    required this.status,
  });

  factory PostPaymentParams.fromJson(Map<String, dynamic> json) =>
      _$PostPaymentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PostPaymentParamsToJson(this);
}
