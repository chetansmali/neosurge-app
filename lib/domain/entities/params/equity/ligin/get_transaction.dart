import 'package:json_annotation/json_annotation.dart';
part 'get_transaction.g.dart';

@JsonSerializable()
class TransactionParams {
  final String email;
  final String broker;

  TransactionParams({
    required this.email,
    required this.broker
});

  factory TransactionParams.fromJson(Map<String, dynamic> json) =>
      _$TransactionParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$TransactionParamsToJson(this);
}