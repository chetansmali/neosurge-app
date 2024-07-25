import 'package:json_annotation/json_annotation.dart';

part 'remove_fund_from_cart_params.g.dart';

@JsonSerializable()
class RemoveFundFromCartParams {
  @JsonKey(name: 'cartID')
  final int fundCartId;

  RemoveFundFromCartParams({
    required this.fundCartId,
  });

  factory RemoveFundFromCartParams.fromJson(Map<String, dynamic> json) =>
      _$RemoveFundFromCartParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveFundFromCartParamsToJson(this);
}
