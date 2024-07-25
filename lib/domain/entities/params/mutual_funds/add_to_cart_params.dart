import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'add_to_cart_params.g.dart';

@JsonSerializable()
class AddToCartParams {
  @JsonKey(
    toJson: investmentTypeToJson,
  )
  final InvestmentType purchaseType;
  final String schemeCode;
  final double amount;
  @JsonKey(name: 'sipObject')
  final SipParams? sipParams;

  AddToCartParams({
    required this.purchaseType,
    required this.schemeCode,
    required this.amount,
    this.sipParams,
  });

  factory AddToCartParams.fromJson(Map<String, dynamic> json) =>
      _$AddToCartParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartParamsToJson(this);

  static String investmentTypeToJson(InvestmentType investmentType) {
    switch (investmentType) {
      case InvestmentType.monthlySip:
        return 'SIP';
      case InvestmentType.lumpsum:
        return 'Lumpsum';
    }
  }
}

@JsonSerializable()
class SipParams {
  final int installments;
  final int invDate;

  SipParams({
    required this.installments,
    required this.invDate,
  });

  factory SipParams.fromJson(Map<String, dynamic> json) =>
      _$SipParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SipParamsToJson(this);
}
