import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_fatca_details_model.g.dart';

@JsonSerializable()
class GetKycFatcaDetailsModel {
  final double grossAnnualIncome;
  final DropDownItem fatcaSourceOfWealth;
  final DropDownItem countryOfBirth;
  final DropDownItem? taxResidencyCountry;
  final String? taxIdentificationNum;
  final String? typeOfTaxIdentification;
  final bool haveAnotherTaxResidence;

  GetKycFatcaDetailsModel({
    required this.grossAnnualIncome,
    required this.fatcaSourceOfWealth,
    required this.countryOfBirth,
    this.taxResidencyCountry,
    this.taxIdentificationNum,
    this.typeOfTaxIdentification,
    required this.haveAnotherTaxResidence,
  });

  factory GetKycFatcaDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycFatcaDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycFatcaDetailsModelToJson(this);
}
