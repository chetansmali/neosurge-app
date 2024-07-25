// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_fatca_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFatcaDetailsParams _$UploadFatcaDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    UploadFatcaDetailsParams(
      haveAnotherTaxResidence: json['haveAnotherTaxResidence'] as bool,
      taxResidencyCountryId: json['taxResidencyCountryId'] as int?,
      countryOfBirthId: json['countryOfBirthId'] as int,
      typeOfTaxIdentification: json['typeOfTaxIdentification'] as String?,
      taxIdentificationNum: json['taxIdentificationNum'] as String?,
      fatcaSourceOfWealthId: json['fatcaSourceOfWealthId'] as int,
      grossAnnualIncome: (json['grossAnnualIncome'] as num).toDouble(),
    );

Map<String, dynamic> _$UploadFatcaDetailsParamsToJson(
        UploadFatcaDetailsParams instance) =>
    <String, dynamic>{
      'haveAnotherTaxResidence': instance.haveAnotherTaxResidence,
      'taxResidencyCountryId': instance.taxResidencyCountryId,
      'countryOfBirthId': instance.countryOfBirthId,
      'typeOfTaxIdentification': instance.typeOfTaxIdentification,
      'taxIdentificationNum': instance.taxIdentificationNum,
      'fatcaSourceOfWealthId': instance.fatcaSourceOfWealthId,
      'grossAnnualIncome': instance.grossAnnualIncome,
    };
