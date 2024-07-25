import 'package:json_annotation/json_annotation.dart';

part 'cheque_ocr_read_response_model.g.dart';

@JsonSerializable()
class ChequeOcrReadResponseModel {
  final String accountNumber;
  final String ifscCode;
  final String chequeNumber;
  final String micrCode;
  final bool status;

  ChequeOcrReadResponseModel({
    required this.accountNumber,
    required this.ifscCode,
    required this.chequeNumber,
    required this.micrCode,
    required this.status,
  });

  factory ChequeOcrReadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChequeOcrReadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChequeOcrReadResponseModelToJson(this);
}
