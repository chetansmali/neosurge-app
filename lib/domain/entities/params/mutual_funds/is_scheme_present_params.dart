import 'package:json_annotation/json_annotation.dart';

part 'is_scheme_present_params.g.dart';

@JsonSerializable()
class IsSchemePresentParams {
  final String schemeID;
  final String purchaseType;

  IsSchemePresentParams({
    required this.schemeID,
    required this.purchaseType,
  });

  factory IsSchemePresentParams.fromJson(Map<String, dynamic> json) =>
      _$IsSchemePresentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$IsSchemePresentParamsToJson(this);
}
