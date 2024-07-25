import 'package:json_annotation/json_annotation.dart';

part 'assisted_service_details_response.g.dart';

@JsonSerializable()
class AssistedServiceDetailsResponse {
  final int id;
  final double amount;
  final int tenure;
  final DateTime createdAt;
  final DateTime updatedAt;

  AssistedServiceDetailsResponse({
    required this.id,
    required this.amount,
    required this.tenure,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssistedServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$AssistedServiceDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssistedServiceDetailsResponseToJson(this);
}
