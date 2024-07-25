import 'package:json_annotation/json_annotation.dart';

part 'delete_mandate_params.g.dart';

@JsonSerializable()
class DeleteMandateParams {
  final bool? closeAll;
  @JsonKey(name: 'mandateID')
  final int? mandateId;
  @JsonKey(name: 'alternateID')
  final int? alternateId;

  DeleteMandateParams({
    this.closeAll,
    this.mandateId,
    this.alternateId,
  });

  factory DeleteMandateParams.fromJson(Map<String, dynamic> json) =>
      _$DeleteMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteMandateParamsToJson(this);
}
