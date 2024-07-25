import 'package:json_annotation/json_annotation.dart';
part 'remove_alert_model.g.dart';

@JsonSerializable()
class RemoveAlertModel {
  final bool? success;
  final String? message;
  final List<String>? data;

  RemoveAlertModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory RemoveAlertModel.fromJson(Map<String, dynamic> json) =>
      _$RemoveAlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAlertModelToJson(this);
}
