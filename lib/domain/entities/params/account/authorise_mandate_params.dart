import 'package:json_annotation/json_annotation.dart';

part 'authorise_mandate_params.g.dart';

@JsonSerializable()
class AuthoriseMandateParams {
  final int mandateId;
  final bool isWeb;

  AuthoriseMandateParams({
    required this.mandateId,
    this.isWeb = false,
  }) : assert(isWeb == false, 'isWeb for phone should be false');

  factory AuthoriseMandateParams.fromJson(Map<String, dynamic> json) =>
      _$AuthoriseMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthoriseMandateParamsToJson(this);
}
