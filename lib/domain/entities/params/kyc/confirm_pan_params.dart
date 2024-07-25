import 'package:json_annotation/json_annotation.dart';

part 'confirm_pan_params.g.dart';

@JsonSerializable()
class ConfirmPanParams {
  final String panNumber;
  final String fullName;
  final String dateOfBirth;
  final bool isCompliant;

  ConfirmPanParams({
    required this.panNumber,
    required this.fullName,
    required this.dateOfBirth,
    required this.isCompliant,
  });

  factory ConfirmPanParams.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPanParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPanParamsToJson(this);
}
