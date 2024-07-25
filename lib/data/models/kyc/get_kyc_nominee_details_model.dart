import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_nominee_details_model.g.dart';

@JsonSerializable()
class GetKycNomineeDetailsModel {
  final int id;
  final String nomineeFullName;
  final DateTime nomineeDateOfBirth;
  final DropDownItem nomineeRelationType;
  final double allocationPercentage;
  final String? guardianName;
  final DropDownItem? guardianRelationship;

  GetKycNomineeDetailsModel({
    required this.id,
    required this.nomineeFullName,
    required this.nomineeDateOfBirth,
    required this.nomineeRelationType,
    required this.allocationPercentage,
    this.guardianName,
    this.guardianRelationship,
  });

  factory GetKycNomineeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycNomineeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycNomineeDetailsModelToJson(this);
}
