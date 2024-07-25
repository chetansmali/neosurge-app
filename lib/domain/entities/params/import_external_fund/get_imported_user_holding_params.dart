import 'package:json_annotation/json_annotation.dart';

part 'get_imported_user_holding_params.g.dart';

@JsonSerializable()
class GetImportedUserHoldingParams {
  final int userID;

  GetImportedUserHoldingParams({required this.userID});

  factory GetImportedUserHoldingParams.fromJson(Map<String, dynamic> json) =>
      _$GetImportedUserHoldingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetImportedUserHoldingParamsToJson(this);
}
