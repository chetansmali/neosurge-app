import 'package:json_annotation/json_annotation.dart';

part 'razor_pay_error_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RazorPayErrorResponseModel {
  final String code;
  final String description;
  final String? field;
  final String source;
  final String step;
  final String reason;
  final ErrorMetaDataModel? metadata;

  RazorPayErrorResponseModel({
    required this.code,
    required this.description,
    this.field,
    required this.source,
    required this.step,
    required this.reason,
    required this.metadata,
  });

  factory RazorPayErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RazorPayErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RazorPayErrorResponseModelToJson(this);

//from string to json method

// factory RazorPayErrorResponseModel.fromString(String string) =>
//     _$RazorPayErrorResponseModelFromString(string);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorMetaDataModel {
  final String paymentId;
  final String orderId;

  ErrorMetaDataModel({
    required this.paymentId,
    required this.orderId,
  });

  factory ErrorMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorMetaDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMetaDataModelToJson(this);
}
