import 'package:json_annotation/json_annotation.dart';

part 'initiate_withdrawal_details.g.dart';

@JsonSerializable()
class InitiateWithdrawalDetails {
  final String interactionToken;
  InitiateWithdrawalDetails(this.interactionToken);

  factory InitiateWithdrawalDetails.fromJson(Map<String, dynamic> json) =>
      _$InitiateWithdrawalDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$InitiateWithdrawalDetailsToJson(this);
}
