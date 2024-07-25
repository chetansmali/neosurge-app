import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'get_dg_transaction_params.g.dart';

@JsonSerializable()
class GetDGTransactionParams {
  final DgTransactionStatus status;

  /// The limit of number of transactions to be returned.  Default is 10.
  final int limit;

  /// The page number to retrieve. Default is 1.
  final int from;

  /// The type of transaction that needs to be returned. If it's null then delivery transactions will be returned.
  final DGTransactionType? type;

  GetDGTransactionParams({
    required this.status,
    this.limit = 10,
    this.from = 1,
    this.type,
  });

  factory GetDGTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$GetDGTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetDGTransactionParamsToJson(this);
}
