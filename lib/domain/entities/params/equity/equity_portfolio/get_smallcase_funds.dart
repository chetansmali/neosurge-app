import 'package:json_annotation/json_annotation.dart';
part 'get_smallcase_funds.g.dart';
@JsonSerializable()
class GetFundasParams{
  final String email;

  GetFundasParams({
    required this.email,
});
  factory GetFundasParams.fromJson(Map<String, dynamic> json) =>
      _$GetFundasParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$GetFundasParamsToJson(this);
}