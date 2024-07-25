import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';
import '../../../flavors.dart';

part 'dg_transaction_response_model.g.dart';

@JsonSerializable()
//  "id": 70,
//             "quantity": 0.0559,
//             "totalAmount": 300.0,
//             "metalType": "gold",
//             "rate": 5208.73,
//             "transactionId": "BE167316541566254250125333",
//             "status": "SUCCESS",
//             "augmontStatus": "Pending",
//             "orderType": "BUY",
//             "createdAt": "2022-06-02T07:57:00.121+00:00"
class DgTransactionResponseModel {
  final int id;
  final double? quantity;
  final double? totalAmount;
  final MetalType metalType;
  final double rate;
  final String? transactionId;
  final DgTransactionStatus status;
  final String augmontStatus;
  final DGOrderType orderType;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get invoiceUrl =>
      '${F.baseUrl}/ff/uploads/invoice/invoice_$transactionId.pdf';

  DgTransactionResponseModel({
    required this.id,
    this.quantity,
    this.totalAmount,
    required this.metalType,
    required this.rate,
    this.transactionId,
    required this.status,
    required this.augmontStatus,
    required this.orderType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DgTransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DgTransactionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DgTransactionResponseModelToJson(this);
}
