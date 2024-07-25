import 'package:json_annotation/json_annotation.dart';

part 'get_broker_holding_params.g.dart';

@JsonSerializable()
class GetBrokerHoldingParams {
  final int id;
  final String brokerName;

  GetBrokerHoldingParams({
    required this.id,
    required this.brokerName,
  });

  factory GetBrokerHoldingParams.fromJson(Map<String, dynamic> json) =>
      _$GetBrokerHoldingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrokerHoldingParamsToJson(this);
}
