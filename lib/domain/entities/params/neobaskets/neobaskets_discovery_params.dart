
import 'package:json_annotation/json_annotation.dart';

part 'neobaskets_discovery_params.g.dart';

@JsonSerializable()
class NeobasketDiscoveryParams {
  final String searchTerm;
  final String sortBy;
  NeobasketDiscoveryParams({
    required this.searchTerm,
    required this.sortBy,
  });

  factory NeobasketDiscoveryParams.fromJson(Map<String, dynamic> json) =>
      _$NeobasketDiscoveryParamsFromJson(json);
  Map<String, dynamic> toJson() => _$NeobasketDiscoveryParamsToJson(this);
}
