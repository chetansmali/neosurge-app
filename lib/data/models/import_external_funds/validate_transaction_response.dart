import 'package:json_annotation/json_annotation.dart';

part 'validate_transaction_response.g.dart';

@JsonSerializable()
class ValidateTransactionResponse {
  final String transactionID;
  final bool success;
  final String errorMessage;

  ValidateTransactionResponse({
    required this.transactionID,
    required this.success,
    required this.errorMessage,
  });

  factory ValidateTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateTransactionResponseToJson(this);
}
