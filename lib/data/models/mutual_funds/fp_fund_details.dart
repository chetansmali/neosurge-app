import 'package:json_annotation/json_annotation.dart';

part 'fp_fund_details.g.dart';

@JsonSerializable()
class FpFundDetails {
//  "fundSchemeId": 1165,
//         "name": "Canara Rob Ultra Short Term Fund-Reg(WD)",
//         "isin": "INF760K01DF2",
//         "investmentOption": "DIV_REINVESTMENT",
//         "minInitialInvestment": 5000.0,
//         "minAdditionalInvestment": 1000.0,
//         "initialInvestmentMultiples": 1.0,
//         "maxInitialInvestment": 9.99999999E8,
//         "maxAdditionalInvestment": 9.99999999E8,
//         "additionalInvestmentMultiples": 1.0,
//         "minWithdrawalAmount": 100.0,
//         "minWithdrawalUnits": 0.001,
//         "minSwpAmount": 100.0,
//         "maxWithdrawalAmount": 9.9999999E7,
//         "maxWithdrawalUnits": 9.9999999E7,
//         "maxSwpAmount": 9.9999999E7,
//         "withdrawalMultiples": 1.0,
//         "withdrawalMultiplesUnits": 1.0,
//         "isSipAllowed": true,
//         "isSwpAllowed": true,
//         "isStpOutAllowed": true,
//         "isSwitchInAllowed": true,
//         "isStpInAllowed": true,
//         "minSipAmount": 1000.0,
//         "minStpInAmount": 500.0,
//         "maxSipAmount": 1999999.0,
//         "maxStpInAmount": 9.9999999E7,
//         "minSipInstallments": 6,
//         "minStpOutInstallments": 12,
//         "minSwpInstallments": 12,
//         "sipMultiples": 1.0,
//         "swpMultiples": 1.0,
//         "stpInAmountMultiples": 1.0,
//         "sipFrequencyData": "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28",
//         "swpFrequencyData": "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28",
//         "stpFrequencyData": "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28",
//         "minSwitchInAmount": 5000.0,
//         "switchInAmountMultiples": 1.0,
//         "fundCategory": "DEBT",
//         "planType": "REGULAR",
//         "subCategory": "",
//         "amfiCode": "109366",
//         "schemeCode": "TASW",
//         "isPurchaseAllowed": true,
//         "isRedemptionAllowed": true,
//         "isInstaRedemptionAllowed": false,
//         "isSwitchOutAllowed": true,
//         "minSwitchOutAmount": 5000.0,
//         "minSwitchOutUnits": 0.001,
//         "switchOutUnitMultiples": 0.001,
//         "switchOutAmountMultiples": 1.0,
//         "amcId": 6,
//         "rtaId": 2,
//         "switchInMinAmt": 5000.0,
//         "switchMultiples": 0.001

  final int? fundSchemeId;
  final String? name;
  final String? isin;
  final String? investmentOption;
  final double? minInitialInvestment;
  final double? minAdditionalInvestment;
  final double? initialInvestmentMultiples;
  final double? maxInitialInvestment;
  final double? maxAdditionalInvestment;
  final double? additionalInvestmentMultiples;
  final double? minWithdrawalAmount;
  final double? minWithdrawalUnits;
  final double? minSwpAmount;
  final double? maxWithdrawalAmount;
  final double? maxWithdrawalUnits;
  final double? maxSwpAmount;
  final double? withdrawalMultiples;
  final double? withdrawalMultiplesUnits;
  final bool? isSipAllowed;
  final bool? isSwpAllowed;
  final bool? isStpOutAllowed;
  final bool? isSwitchInAllowed;
  final bool? isStpInAllowed;
  final double? minSipAmount;
  final double? minStpInAmount;
  final double? maxSipAmount;
  final double? maxStpInAmount;
  final int? minSipInstallments;
  final int? minStpOutInstallments;
  final int? minSwpInstallments;
  final double? sipMultiples;
  final double? swpMultiples;
  final double? stpInAmountMultiples;
  final String? sipFrequencyData;
  final String? swpFrequencyData;
  final String? stpFrequencyData;
  final double? minSwitchInAmount;
  final double? switchInAmountMultiples;
  final String? fundCategory;
  final String? planType;
  final String? subCategory;
  final String? amfiCode;
  final String? schemeCode;
  final bool? isPurchaseAllowed;
  final bool? isRedemptionAllowed;
  final bool? isInstaRedemptionAllowed;
  final bool? isSwitchOutAllowed;
  final double? minSwitchOutAmount;
  final double? minSwitchOutUnits;
  final double? switchOutUnitMultiples;
  final double? switchOutAmountMultiples;
  final int? amcId;
  final int? rtaId;
  final double? switchInMinAmt;
  final double? switchMultiples;

  List<int>? get validSwpDates {
    if(swpFrequencyData == null) return null;
    return swpFrequencyData!.split(',').map((e) => int.parse(e)).toList();
  }

  List<int>? get validSipDates {
    if(sipFrequencyData == null) return null;
   return sipFrequencyData!.split(',').map((e) => int.parse(e)).toList();
  }

  List<int>? get validStpDates {
    if(stpFrequencyData == null) return null;
    return stpFrequencyData!.split(',').map((e) => int.parse(e)).toList();
  }

  FpFundDetails({
    required this.fundSchemeId,
    required this.name,
    required this.isin,
    required this.investmentOption,
    required this.minInitialInvestment,
    required this.minAdditionalInvestment,
    required this.initialInvestmentMultiples,
    required this.maxInitialInvestment,
    required this.maxAdditionalInvestment,
    required this.additionalInvestmentMultiples,
    required this.minWithdrawalAmount,
    required this.minWithdrawalUnits,
    required this.minSwpAmount,
    required this.maxWithdrawalAmount,
    required this.maxWithdrawalUnits,
    required this.maxSwpAmount,
    required this.withdrawalMultiples,
    required this.withdrawalMultiplesUnits,
    required this.isSipAllowed,
    required this.isSwpAllowed,
    required this.isStpOutAllowed,
    required this.isSwitchInAllowed,
    required this.isStpInAllowed,
    required this.minSipAmount,
    required this.minStpInAmount,
    required this.maxSipAmount,
    required this.maxStpInAmount,
    required this.minSipInstallments,
    required this.minStpOutInstallments,
    required this.minSwpInstallments,
    required this.sipMultiples,
    required this.swpMultiples,
    required this.stpInAmountMultiples,
    required this.sipFrequencyData,
    required this.swpFrequencyData,
    required this.stpFrequencyData,
    required this.minSwitchInAmount,
    required this.switchInAmountMultiples,
    required this.fundCategory,
    required this.planType,
    required this.subCategory,
    required this.amfiCode,
    required this.schemeCode,
    required this.isPurchaseAllowed,
    required this.isRedemptionAllowed,
    required this.isInstaRedemptionAllowed,
    required this.isSwitchOutAllowed,
    required this.minSwitchOutAmount,
    required this.minSwitchOutUnits,
    required this.switchOutUnitMultiples,
    required this.switchOutAmountMultiples,
    required this.amcId,
    required this.rtaId,
    required this.switchInMinAmt,
    required this.switchMultiples,
  });

  factory FpFundDetails.fromJson(Map<String, dynamic> json) =>
      _$FpFundDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FpFundDetailsToJson(this);
}
