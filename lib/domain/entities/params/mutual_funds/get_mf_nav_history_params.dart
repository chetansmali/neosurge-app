import 'package:json_annotation/json_annotation.dart';

part 'get_mf_nav_history_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetMFNavHistoryParams {
  final String schemeCode;
  @JsonKey(toJson: _dateTimeToString)
  final DateTime from;
  @JsonKey(toJson: _dateTimeToString)
  final DateTime to;
  final String frequency;

  GetMFNavHistoryParams({
    required this.schemeCode,
    required this.from,
    required this.to,
    required this.frequency,
  });

  factory GetMFNavHistoryParams.fromJson(Map<String, dynamic> json) =>
      _$GetMFNavHistoryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMFNavHistoryParamsToJson(this);

  static _dateTimeToString(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
}
