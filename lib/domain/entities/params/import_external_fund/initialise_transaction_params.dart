import 'package:json_annotation/json_annotation.dart';

part 'initialise_transaction_params.g.dart';

@JsonSerializable()
class InitialiseTransactionParams {
  final int userID;
  final String panNumber;
  final String phoneNumber;

  InitialiseTransactionParams({
    required this.userID,
    required this.panNumber,
    required this.phoneNumber,
  });

  factory InitialiseTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$InitialiseTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InitialiseTransactionParamsToJson(this);
}
