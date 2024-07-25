import 'package:json_annotation/json_annotation.dart';

part 'imported_holding_response.g.dart';

@JsonSerializable()
class ImportedHoldingResponse {
  final ImportedHoldingUser user;
  final List<HoldingDistribution> holdingDistribution;

  ImportedHoldingResponse({
    required this.user,
    required this.holdingDistribution,
  });

  factory ImportedHoldingResponse.fromJson(Map<String, dynamic> json) =>
      _$ImportedHoldingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImportedHoldingResponseToJson(this);
}

@JsonSerializable()
class ImportedHoldingUser {
  final int? id;
  final int? userID;
  final String? mobileNumber;
  final String? panNumber;
  final int? lastRefresh;
  final double? currentAssetValue;
  final double? investedValue;
  final double? returnValue;
  final double? oneDayChange;
  final double? oneDayChangePercentage;
  final double? xirr;
  final int? holdingsCount;
  final double? returnPercentage;
  final double? equityPercentage;
  final double? debtPercentage;
  final double? hybridPercentage;

  ImportedHoldingUser({
    this.id,
    this.userID,
    this.mobileNumber,
    this.panNumber,
    this.lastRefresh,
    required this.currentAssetValue,
    required this.investedValue,
    required this.returnValue,
    this.oneDayChange,
    this.oneDayChangePercentage,
    this.xirr,
    this.holdingsCount,
    required this.returnPercentage,
    this.equityPercentage,
    this.debtPercentage,
    this.hybridPercentage,
  });

  factory ImportedHoldingUser.fromJson(Map<String, dynamic> json) =>
      _$ImportedHoldingUserFromJson(json);

  Map<String, dynamic> toJson() => _$ImportedHoldingUserToJson(this);
}

@JsonSerializable()
class HoldingDistribution {
  final int id;
  final int userID;
  final String brokerName;
  final double? currentAssetValue;
  final double? currentInvestment;
  final double? currentReturns;

  HoldingDistribution({
    required this.id,
    required this.userID,
    required this.brokerName,
    required this.currentAssetValue,
    required this.currentInvestment,
    required this.currentReturns,
  });

  factory HoldingDistribution.fromJson(Map<String, dynamic> json) =>
      _$HoldingDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingDistributionToJson(this);
}
