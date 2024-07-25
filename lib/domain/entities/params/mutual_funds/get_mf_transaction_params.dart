import 'package:json_annotation/json_annotation.dart';

part 'get_mf_transaction_params.g.dart';

@JsonSerializable()
class GetMfTransactionParams {
  final String isin;
  final String folio;

  GetMfTransactionParams({
    required this.isin,
    required this.folio,
  });

  factory GetMfTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$GetMfTransactionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMfTransactionParamsToJson(this);
}
