import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'initiate_lumpsum_purchase_params.g.dart';

@JsonSerializable()
class InitiateLumpsumPurchaseParams {
  final int userId;
  final MFPaymentTypes paymentType;
  final String? euin;
  final String? referenceCode;
  final int id;
  final bool isWeb;

  InitiateLumpsumPurchaseParams({
    required this.userId,
    required this.paymentType,
    required this.id,
    this.euin,
    this.referenceCode,
    this.isWeb = false,
  }) : assert(isWeb == false, "isWeb should be false");

  factory InitiateLumpsumPurchaseParams.fromJson(Map<String, dynamic> json) =>
      _$InitiateLumpsumPurchaseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InitiateLumpsumPurchaseParamsToJson(this);
}
