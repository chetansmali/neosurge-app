import 'package:json_annotation/json_annotation.dart';

part 'swp_order_response.g.dart';

@JsonSerializable()
class SwpOrderResponse {
  final int id;

  SwpOrderResponse({
    required this.id,
  });

  factory SwpOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$SwpOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwpOrderResponseToJson(this);
}
