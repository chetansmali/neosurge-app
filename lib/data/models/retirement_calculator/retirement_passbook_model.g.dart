// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retirement_passbook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirementPassbookModel _$RetirementPassbookModelFromJson(
        Map<String, dynamic> json) =>
    RetirementPassbookModel(
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentCompany: json['currentCompany'] as String?,
      isPassbookStored: json['isPassbookStored'] as bool,
      currentCompanyEstablishmentId:
          json['currentCompanyEstablishmentId'] as String?,
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      uan: json['uan'] as String?,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$RetirementPassbookModelToJson(
        RetirementPassbookModel instance) =>
    <String, dynamic>{
      'uan': instance.uan,
      'fullName': instance.fullName,
      'companies': instance.companies,
      'currentCompany': instance.currentCompany,
      'currentCompanyEstablishmentId': instance.currentCompanyEstablishmentId,
      'totalValue': instance.totalValue,
      'isPassbookStored': instance.isPassbookStored,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      passbook: (json['passbook'] as List<dynamic>)
          .map((e) => Passbook.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyName: json['company_name'] as String?,
      establishmentId: json['establishment_id'] as String?,
      employeeTotal: (json['employee_total'] as num?)?.toDouble(),
      employerTotal: (json['employer_total'] as num?)?.toDouble(),
      pensionTotal: (json['pension_total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'passbook': instance.passbook,
      'company_name': instance.companyName,
      'establishment_id': instance.establishmentId,
      'employee_total': instance.employeeTotal,
      'employer_total': instance.employerTotal,
      'pension_total': instance.pensionTotal,
    };

Passbook _$PassbookFromJson(Map<String, dynamic> json) => Passbook(
      description: json['description'] as String?,
      year: json['year'] as int?,
      month: json['month'] as int?,
      memberId: json['memberId'] as String?,
      approvedOn: json['approved_on'] == null
          ? null
          : DateTime.parse(json['approved_on'] as String),
      employeeShare: (json['employee_share'] as num?)?.toDouble(),
      employerShare: (json['employer_share'] as num?)?.toDouble(),
      pensionShare: (json['pension_share'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PassbookToJson(Passbook instance) => <String, dynamic>{
      'description': instance.description,
      'year': instance.year,
      'month': instance.month,
      'memberId': instance.memberId,
      'approved_on': instance.approvedOn?.toIso8601String(),
      'employee_share': instance.employeeShare,
      'employer_share': instance.employerShare,
      'pension_share': instance.pensionShare,
    };
