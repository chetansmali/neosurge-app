import 'package:json_annotation/json_annotation.dart';

part 'user_id_param.g.dart';

@JsonSerializable()
class UserIdParam {
  UserIdParam({required this.userId});

  final int userId;

  factory UserIdParam.fromJson(Map<String, dynamic> json) =>
      _$UserIdParamFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdParamToJson(this);
}
