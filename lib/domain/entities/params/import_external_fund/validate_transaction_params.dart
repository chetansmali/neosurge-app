import 'package:json_annotation/json_annotation.dart';

part 'validate_transaction_params.g.dart';

@JsonSerializable()
class ValidateTransactionParams {
  final int userID;
  final String panNumber;
  final String phoneNumber;
  final String transactionID;
  final String? otp;

  ValidateTransactionParams({
    required this.userID,
    required this.panNumber,
    required this.phoneNumber,
    required this.transactionID,
    this.otp,
  });

  factory ValidateTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$ValidateTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateTransactionParamsToJson(this);
}
