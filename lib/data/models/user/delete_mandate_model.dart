import 'package:json_annotation/json_annotation.dart';

part 'delete_mandate_model.g.dart';

@JsonSerializable()
class DeleteMandateModel {
  final String status;
  @JsonKey(name: 'deleteID')
  final String deleteId;

  DeleteMandateModel({
    required this.status,
    required this.deleteId,
  });

  factory DeleteMandateModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteMandateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteMandateModelToJson(this);
}
