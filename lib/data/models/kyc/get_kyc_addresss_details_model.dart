import 'package:json_annotation/json_annotation.dart';

import '../../../constants/dropdown_constants.dart';

part 'get_kyc_addresss_details_model.g.dart';

@JsonSerializable()
class GetKycAddressDetailsModel {
  final String permAddressLine1;
  final String permAddressLine2;
  final String permCity;
  final int permPincode;
  final DropDownItem permState;
  final DropDownItem permCountry;
  final bool permSameAsCurr;
  final String? currAddressLine1;
  final String? currAddressLine2;
  final String? currCity;
  final int? currPincode;
  final DropDownItem? currState;
  final DropDownItem? currCountry;

  GetKycAddressDetailsModel({
    required this.permAddressLine1,
    required this.permAddressLine2,
    required this.permCity,
    required this.permPincode,
    required this.permState,
    required this.permCountry,
    required this.permSameAsCurr,
    this.currAddressLine1,
    this.currAddressLine2,
    this.currCity,
    this.currPincode,
    this.currState,
    this.currCountry,
  });

  factory GetKycAddressDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetKycAddressDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycAddressDetailsModelToJson(this);
}
