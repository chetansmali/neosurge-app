import 'package:json_annotation/json_annotation.dart';

part 'get_import_landing_page_model.g.dart';

@JsonSerializable()
class GetImportLandingPageResponse {
  int? cibilScore;
  double? loanSanctioned;
  double? amountPending;
  double? totalEMI;
  int? activeLoans;
  bool? refreshAvailable;
  LAMFLoanListModel? loans;

  GetImportLandingPageResponse({
    this.cibilScore,
    this.loanSanctioned,
    this.amountPending,
    this.totalEMI,
    this.activeLoans,
    this.refreshAvailable,
    this.loans,
  });

  factory GetImportLandingPageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetImportLandingPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetImportLandingPageResponseToJson(this);
}

@JsonSerializable()
class LAMFLoanListModel {
  LAMFSecUnsecLoanObjectModel? secured;
  LAMFSecUnsecLoanObjectModel? unsecured;

  LAMFLoanListModel({
    this.secured,
    this.unsecured,
  });

  factory LAMFLoanListModel.fromJson(Map<String, dynamic> json) =>
      _$LAMFLoanListModelFromJson(json);

  Map<String, dynamic> toJson() => _$LAMFLoanListModelToJson(this);
}

@JsonSerializable()
class LAMFSecUnsecLoanObjectModel {
  List<LAMFLoanObjectModel>? active;
  List<LAMFLoanObjectModel>? closed;

  LAMFSecUnsecLoanObjectModel({
    this.active,
    this.closed,
  });

  factory LAMFSecUnsecLoanObjectModel.fromJson(Map<String, dynamic> json) =>
      _$LAMFSecUnsecLoanObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$LAMFSecUnsecLoanObjectModelToJson(this);
}

@JsonSerializable()
class LAMFLoanObjectModel {
  String? loanType;
  String? provider;
  String? accountNumber;
  String? accountID;

  LAMFLoanObjectModel({
    this.loanType,
    this.provider,
    this.accountNumber,
    this.accountID,
  });

  factory LAMFLoanObjectModel.fromJson(Map<String, dynamic> json) =>
      _$LAMFLoanObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$LAMFLoanObjectModelToJson(this);
}
