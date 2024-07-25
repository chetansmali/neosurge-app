import 'package:json_annotation/json_annotation.dart';

part 'get_pledged_funds_details.g.dart';

@JsonSerializable()
class GetPledgedFundsDetails {
  final List<PledgedHolding> pledgedHoldings;
  GetPledgedFundsDetails(this.pledgedHoldings);

  factory GetPledgedFundsDetails.fromJson(Map<String, dynamic> json) =>
      _$GetPledgedFundsDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GetPledgedFundsDetailsToJson(this);
}

@JsonSerializable()
class PledgedHolding {
  final double creditLimit;
  final String scripName;

  PledgedHolding({
    required this.creditLimit,
    required this.scripName,
  });

  factory PledgedHolding.fromJson(Map<String, dynamic> json) =>
      _$PledgedHoldingFromJson(json);
  Map<String, dynamic> toJson() => _$PledgedHoldingToJson(this);
}
