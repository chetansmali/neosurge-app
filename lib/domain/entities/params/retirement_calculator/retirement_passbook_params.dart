import 'package:json_annotation/json_annotation.dart';
part 'retirement_passbook_params.g.dart';

@JsonSerializable()
class RetirementPassbookParams {
  final String requestId;
  final String refreshNeeded;

  RetirementPassbookParams({
    required this.requestId,
    required this.refreshNeeded,
  });
  factory RetirementPassbookParams.fromJson(Map<String, dynamic> json) =>
      _$RetirementPassbookParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RetirementPassbookParamsToJson(this);
}
