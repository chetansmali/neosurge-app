import 'package:json_annotation/json_annotation.dart';
part 'retirement_passbook_model.g.dart';

@JsonSerializable()
class RetirementPassbookModel {
  final String? uan;
  final String? fullName;
  final List<Company>? companies;
  final String? currentCompany;
  final String? currentCompanyEstablishmentId;
  final double? totalValue;
  final bool isPassbookStored;

  RetirementPassbookModel({
    required this.companies,
    required this.currentCompany,
    required this.isPassbookStored,
    required this.currentCompanyEstablishmentId,
    required this.totalValue,
    required this.uan,
    required this.fullName,
  });
  factory RetirementPassbookModel.fromJson(Map<String, dynamic> json) =>
      _$RetirementPassbookModelFromJson(json);

  Map<String, dynamic> toJson() => _$RetirementPassbookModelToJson(this);
}

@JsonSerializable()
class Company {
  final List<Passbook> passbook;
  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'establishment_id')
  final String? establishmentId;
  @JsonKey(name: 'employee_total')
  final double? employeeTotal;
  @JsonKey(name: 'employer_total')
  final double? employerTotal;

  @JsonKey(name: 'pension_total')
  final double? pensionTotal;

  Company({
    required this.passbook,
    required this.companyName,
    required this.establishmentId,
    required this.employeeTotal,
    required this.employerTotal,
    required this.pensionTotal,
  });
  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class Passbook {
  final String? description;
  final int? year;
  final int? month;
  final String? memberId;
  @JsonKey(name: 'approved_on')
  final DateTime? approvedOn;
  @JsonKey(name: 'employee_share')
  final double? employeeShare;
  @JsonKey(name: 'employer_share')
  final double? employerShare;
  @JsonKey(name: 'pension_share')
  final double? pensionShare;

  Passbook({
    required this.description,
    required this.year,
    required this.month,
    required this.memberId,
    required this.approvedOn,
    required this.employeeShare,
    required this.employerShare,
    required this.pensionShare,
  });
  factory Passbook.fromJson(Map<String, dynamic> json) =>
      _$PassbookFromJson(json);

  Map<String, dynamic> toJson() => _$PassbookToJson(this);
}
