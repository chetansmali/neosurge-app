import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'get_delivery_product_params.g.dart';

@JsonSerializable()
class GetDeliveryProductParams {
  final MetalType metalType;

  GetDeliveryProductParams({
    required this.metalType,
  });

  Map<String, dynamic> toJson() => _$GetDeliveryProductParamsToJson(this);

  static GetDeliveryProductParams fromJson(Map<String, dynamic> json) =>
      _$GetDeliveryProductParamsFromJson(json);
}
