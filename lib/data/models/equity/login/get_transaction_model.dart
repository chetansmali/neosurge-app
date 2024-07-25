import 'package:json_annotation/json_annotation.dart';
part 'get_transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String? transactionId;
  final String? smallcaseAuthToken;
  final String? smallcaseBrokerKey;
  final bool success;
  final String? message;

  TransactionModel({
    required this.smallcaseAuthToken,
    required this.smallcaseBrokerKey,
    required this.success,
    required this.transactionId,
    required this.message
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
