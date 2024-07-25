import 'package:json_annotation/json_annotation.dart';

part 'user_bank_mandate_model.g.dart';

@JsonSerializable()
class UserBankMandateModel {
  @JsonKey(name: 'mandateID')
  final int mandateId;
  final String status;
  final String createdOn;

  UserBankMandateModel({
    required this.mandateId,
    required this.status,
    required this.createdOn,
  });

  factory UserBankMandateModel.fromJson(Map<String, dynamic> json) =>
      _$UserBankMandateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankMandateModelToJson(this);
}
