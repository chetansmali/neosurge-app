import 'package:json_annotation/json_annotation.dart';

part 'unlock_assisted_service_params.g.dart';

@JsonSerializable()
class UnlockAssistedServiceParams {
  final double amount;

  UnlockAssistedServiceParams({
    required this.amount,
  });

  factory UnlockAssistedServiceParams.fromJson(Map<String, dynamic> json) =>
      _$UnlockAssistedServiceParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockAssistedServiceParamsToJson(this);
}
