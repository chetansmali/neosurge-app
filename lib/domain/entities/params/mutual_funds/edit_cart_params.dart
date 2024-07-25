import 'package:json_annotation/json_annotation.dart';

part 'edit_cart_params.g.dart';

@JsonSerializable()
class EditCartParams {
  final int cartItemID;
  final int newAmount;

  EditCartParams({
    required this.cartItemID,
    required this.newAmount,
  });

  factory EditCartParams.fromJson(Map<String, dynamic> json) =>
      _$EditCartParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EditCartParamsToJson(this);
}
