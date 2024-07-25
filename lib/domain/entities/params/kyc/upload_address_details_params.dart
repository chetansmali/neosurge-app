import 'package:json_annotation/json_annotation.dart';

part 'upload_address_details_params.g.dart';

@JsonSerializable()
class UploadAddressDetailsParams {
  final String permAddressLine1;
  final String permAddressLine2;
  final String permCity;
  final int permPincode;
  final int permState;
  final int permCountry;
  final bool permSameAsCurr;
  final String? currAddressLine1;
  final String? currAddressLine2;
  final String? currCity;
  final int? currPincode;
  final int? currState;
  final int? currCountry;

  UploadAddressDetailsParams({
    required this.permAddressLine1,
    required this.permAddressLine2,
    required this.permCity,
    required this.permPincode,
    required this.permState,
    this.permCountry = 101,
    required this.permSameAsCurr,
    this.currAddressLine1,
    this.currAddressLine2,
    this.currCity,
    this.currPincode,
    this.currState,
    this.currCountry = 101,
  });

  factory UploadAddressDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$UploadAddressDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UploadAddressDetailsParamsToJson(this);
}
