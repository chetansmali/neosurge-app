import 'package:json_annotation/json_annotation.dart';

part 'get_pincode_data_model.g.dart';

@JsonSerializable()
class PinCodeDataModel {
  final String code;
  final String city;
  final String district;
  @JsonKey(name: 'state_name')
  final String stateName;
  @JsonKey(name: 'country_ansi_code')
  final String countryAnsiCode;
  @JsonKey(name: 'country_name')
  final String countryName;

  PinCodeDataModel({
    required this.code,
    required this.city,
    required this.district,
    required this.stateName,
    required this.countryAnsiCode,
    required this.countryName,
  });

  factory PinCodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PinCodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PinCodeDataModelToJson(this);
}
