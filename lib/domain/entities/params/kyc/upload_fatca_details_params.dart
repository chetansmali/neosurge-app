import 'package:json_annotation/json_annotation.dart';

part 'upload_fatca_details_params.g.dart';

@JsonSerializable()
class UploadFatcaDetailsParams {
  final bool haveAnotherTaxResidence;
  final int? taxResidencyCountryId;
  final int countryOfBirthId;
  final String? typeOfTaxIdentification;
  final String? taxIdentificationNum;
  final int fatcaSourceOfWealthId;
  final double grossAnnualIncome;

  UploadFatcaDetailsParams({
    required this.haveAnotherTaxResidence,
    required this.taxResidencyCountryId,
    required this.countryOfBirthId,
    required this.typeOfTaxIdentification,
    required this.taxIdentificationNum,
    required this.fatcaSourceOfWealthId,
    required this.grossAnnualIncome,
  });

  factory UploadFatcaDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$UploadFatcaDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFatcaDetailsParamsToJson(this);
}
