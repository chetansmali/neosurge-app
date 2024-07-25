import 'package:json_annotation/json_annotation.dart';
part 'update_loan_params.g.dart';

@JsonSerializable()
class UpdateLoanParams {
  final String applicationState;

  UpdateLoanParams({required this.applicationState});

  factory UpdateLoanParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateLoanParamsFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLoanParamsToJson(this);
}
