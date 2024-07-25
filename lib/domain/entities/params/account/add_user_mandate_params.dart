import 'package:json_annotation/json_annotation.dart';

part 'add_user_mandate_params.g.dart';

@JsonSerializable()
class AddUserMandateParams {
  final double limit;
  final int bankId;
  final bool isWeb;

  AddUserMandateParams({
    required this.limit,
    required this.bankId,
    this.isWeb = false,
  }) : assert(isWeb == false, 'isWeb for phone should be false');

  factory AddUserMandateParams.fromJson(Map<String, dynamic> json) =>
      _$AddUserMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserMandateParamsToJson(this);
}
