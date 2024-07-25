import 'package:json_annotation/json_annotation.dart';

part 'verify_pan_response_model.g.dart';

@JsonSerializable()
class VerifyPanResponseModel {
  final String? fullName;
  final bool isCompliant;
  final String panNumber;

  const VerifyPanResponseModel({
    this.fullName,
    required this.isCompliant,
    required this.panNumber,
  });

  factory VerifyPanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyPanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPanResponseModelToJson(this);
}
