// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_import_landing_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImportLandingPageResponse _$GetImportLandingPageResponseFromJson(
        Map<String, dynamic> json) =>
    GetImportLandingPageResponse(
      cibilScore: json['cibilScore'] as int?,
      loanSanctioned: (json['loanSanctioned'] as num?)?.toDouble(),
      amountPending: (json['amountPending'] as num?)?.toDouble(),
      totalEMI: (json['totalEMI'] as num?)?.toDouble(),
      activeLoans: json['activeLoans'] as int?,
      refreshAvailable: json['refreshAvailable'] as bool?,
      loans: json['loans'] == null
          ? null
          : LAMFLoanListModel.fromJson(json['loans'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetImportLandingPageResponseToJson(
        GetImportLandingPageResponse instance) =>
    <String, dynamic>{
      'cibilScore': instance.cibilScore,
      'loanSanctioned': instance.loanSanctioned,
      'amountPending': instance.amountPending,
      'totalEMI': instance.totalEMI,
      'activeLoans': instance.activeLoans,
      'refreshAvailable': instance.refreshAvailable,
      'loans': instance.loans,
    };

LAMFLoanListModel _$LAMFLoanListModelFromJson(Map<String, dynamic> json) =>
    LAMFLoanListModel(
      secured: json['secured'] == null
          ? null
          : LAMFSecUnsecLoanObjectModel.fromJson(
              json['secured'] as Map<String, dynamic>),
      unsecured: json['unsecured'] == null
          ? null
          : LAMFSecUnsecLoanObjectModel.fromJson(
              json['unsecured'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LAMFLoanListModelToJson(LAMFLoanListModel instance) =>
    <String, dynamic>{
      'secured': instance.secured,
      'unsecured': instance.unsecured,
    };

LAMFSecUnsecLoanObjectModel _$LAMFSecUnsecLoanObjectModelFromJson(
        Map<String, dynamic> json) =>
    LAMFSecUnsecLoanObjectModel(
      active: (json['active'] as List<dynamic>?)
          ?.map((e) => LAMFLoanObjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      closed: (json['closed'] as List<dynamic>?)
          ?.map((e) => LAMFLoanObjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LAMFSecUnsecLoanObjectModelToJson(
        LAMFSecUnsecLoanObjectModel instance) =>
    <String, dynamic>{
      'active': instance.active,
      'closed': instance.closed,
    };

LAMFLoanObjectModel _$LAMFLoanObjectModelFromJson(Map<String, dynamic> json) =>
    LAMFLoanObjectModel(
      loanType: json['loanType'] as String?,
      provider: json['provider'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountID: json['accountID'] as String?,
    );

Map<String, dynamic> _$LAMFLoanObjectModelToJson(
        LAMFLoanObjectModel instance) =>
    <String, dynamic>{
      'loanType': instance.loanType,
      'provider': instance.provider,
      'accountNumber': instance.accountNumber,
      'accountID': instance.accountID,
    };
