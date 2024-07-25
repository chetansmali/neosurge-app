import 'package:json_annotation/json_annotation.dart';

part 'get_account_details_params.g.dart';

@JsonSerializable()
class GetAccountDetailsParams {
  final int userID;

  GetAccountDetailsParams({required this.userID});

  factory GetAccountDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetAccountDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountDetailsParamsToJson(this);
}
