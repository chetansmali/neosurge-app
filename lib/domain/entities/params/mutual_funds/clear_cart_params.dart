import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'clear_cart_params.g.dart';

@JsonSerializable()
class ClearCartParams {
  @JsonKey(
    toJson: investmentTypeToJson,
  )
  final InvestmentType purchaseType;

  ClearCartParams({
    required this.purchaseType,
  });

  factory ClearCartParams.fromJson(Map<String, dynamic> json) =>
      _$ClearCartParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ClearCartParamsToJson(this);

  static String investmentTypeToJson(InvestmentType investmentType) {
    switch (investmentType) {
      case InvestmentType.monthlySip:
        return 'SIP';
      case InvestmentType.lumpsum:
        return 'Lumpsum';
    }
  }
}
