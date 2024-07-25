import 'package:json_annotation/json_annotation.dart';

part 'get_user_mandate_params.g.dart';

@JsonSerializable()
class GetUserMandateParams {
  final int mandateId;

  GetUserMandateParams({
    required this.mandateId,
  });

  factory GetUserMandateParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserMandateParamsToJson(this);
}
