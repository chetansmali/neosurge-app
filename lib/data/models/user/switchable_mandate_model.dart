// {
//   "mandateID": 8,
//   "mandateLimit": 100000.0,
//   "bankName": "ICICI BANK LIMITED"
// }

import 'package:json_annotation/json_annotation.dart';

part 'switchable_mandate_model.g.dart';

@JsonSerializable()
class SwitchableMandateModel {
  final int mandateID;
  final double mandateLimit;
  final String bankName;

  const SwitchableMandateModel({
    required this.mandateID,
    required this.mandateLimit,
    required this.bankName,
  });

  factory SwitchableMandateModel.fromJson(Map<String, dynamic> json) =>
      _$SwitchableMandateModelFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchableMandateModelToJson(this);
}
