import 'package:json_annotation/json_annotation.dart';

part 'initialise_transaction_response.g.dart';

@JsonSerializable()
class InitialiseTransactionReposnse {
  final String transactionID;
  final bool success;
  final String errorMessage;

  InitialiseTransactionReposnse({
    required this.transactionID,
    required this.success,
    required this.errorMessage,
  });

  factory InitialiseTransactionReposnse.fromJson(Map<String, dynamic> json) =>
      _$InitialiseTransactionReposnseFromJson(json);

  Map<String, dynamic> toJson() => _$InitialiseTransactionReposnseToJson(this);
}
