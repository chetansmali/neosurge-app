import 'package:json_annotation/json_annotation.dart';

part 'ocr_read_response_model.g.dart';

@JsonSerializable()
class OcrReadResponseModel {
  String docNum;
  String docType;
  String dob;
  String? fullName;
  bool status;

  OcrReadResponseModel({
    required this.docNum,
    required this.docType,
    required this.dob,
    this.fullName,
    required this.status,
  });

  factory OcrReadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OcrReadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OcrReadResponseModelToJson(this);
}
