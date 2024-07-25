// {
//     "planName":"abc",
//     "amount":10000,
//     "installmentDay":"5",
//     "sipId":16
// }

import 'package:json_annotation/json_annotation.dart';

part 'mandate_sip_model.g.dart';

@JsonSerializable()
class MandateSipModel {
  final String planName;
  final String? planLogo;
  final double amount;
  final String installmentDay;
  final int sipId;

  MandateSipModel({
    required this.planName,
    this.planLogo,
    required this.amount,
    required this.installmentDay,
    required this.sipId,
  });

  factory MandateSipModel.fromJson(Map<String, dynamic> json) =>
      _$MandateSipModelFromJson(json);

  Map<String, dynamic> toJson() => _$MandateSipModelToJson(this);
}
