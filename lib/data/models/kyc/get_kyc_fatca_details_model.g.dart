// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_fatca_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycFatcaDetailsModel _$GetKycFatcaDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetKycFatcaDetailsModel(
      grossAnnualIncome: (json['grossAnnualIncome'] as num).toDouble(),
      fatcaSourceOfWealth: DropDownItem.fromJson(
          json['fatcaSourceOfWealth'] as Map<String, dynamic>),
      countryOfBirth:
          DropDownItem.fromJson(json['countryOfBirth'] as Map<String, dynamic>),
      taxResidencyCountry: json['taxResidencyCountry'] == null
          ? null
          : DropDownItem.fromJson(
              json['taxResidencyCountry'] as Map<String, dynamic>),
      taxIdentificationNum: json['taxIdentificationNum'] as String?,
      typeOfTaxIdentification: json['typeOfTaxIdentification'] as String?,
      haveAnotherTaxResidence: json['haveAnotherTaxResidence'] as bool,
    );

Map<String, dynamic> _$GetKycFatcaDetailsModelToJson(
        GetKycFatcaDetailsModel instance) =>
    <String, dynamic>{
      'grossAnnualIncome': instance.grossAnnualIncome,
      'fatcaSourceOfWealth': instance.fatcaSourceOfWealth,
      'countryOfBirth': instance.countryOfBirth,
      'taxResidencyCountry': instance.taxResidencyCountry,
      'taxIdentificationNum': instance.taxIdentificationNum,
      'typeOfTaxIdentification': instance.typeOfTaxIdentification,
      'haveAnotherTaxResidence': instance.haveAnotherTaxResidence,
    };
