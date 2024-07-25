import 'package:json_annotation/json_annotation.dart';

part 'stp_order_response.g.dart';

@JsonSerializable()
class StpOrderResponse {
  final int id;

  StpOrderResponse({
    required this.id,
  });

  factory StpOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$StpOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StpOrderResponseToJson(this);
}
