import 'package:json_annotation/json_annotation.dart';
part 'get_smallcase_fund.g.dart';

@JsonSerializable()
class GetFundsModel{
  final String transactionId;

  GetFundsModel({
    required this.transactionId,
});
  factory GetFundsModel.fromJson(Map<String, dynamic> json) =>
      _$GetFundsModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$GetFundsModelToJson(this);
}