import 'package:json_annotation/json_annotation.dart';
part 'neobaskets_discovery_details.g.dart';

@JsonSerializable()
class NeobasketsDiscoveryDetails {
  final String basketID;
  final String? name;
  final String? description;
  final String? imageURL; // Nullable
  final double? cagr;
  final double? minSIP;
  final double? aum;
  final bool? isThreeYearReturns;

  NeobasketsDiscoveryDetails({
    required this.basketID,
    required this.name,
    required this.description,
    this.imageURL,
    required this.cagr,
    required this.minSIP,
    required this.aum,
    required this.isThreeYearReturns,
  });

  factory NeobasketsDiscoveryDetails.fromJson(Map<String, dynamic> json) =>
      _$NeobasketsDiscoveryDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$NeobasketsDiscoveryDetailsToJson(this);

  static List<NeobasketsDiscoveryDetails> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((basket) => NeobasketsDiscoveryDetails.fromJson(basket))
        .toList();
  }
}
