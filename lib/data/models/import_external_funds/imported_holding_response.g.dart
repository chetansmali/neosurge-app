// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imported_holding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportedHoldingResponse _$ImportedHoldingResponseFromJson(
        Map<String, dynamic> json) =>
    ImportedHoldingResponse(
      user: ImportedHoldingUser.fromJson(json['user'] as Map<String, dynamic>),
      holdingDistribution: (json['holdingDistribution'] as List<dynamic>)
          .map((e) => HoldingDistribution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImportedHoldingResponseToJson(
        ImportedHoldingResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'holdingDistribution': instance.holdingDistribution,
    };

ImportedHoldingUser _$ImportedHoldingUserFromJson(Map<String, dynamic> json) =>
    ImportedHoldingUser(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      mobileNumber: json['mobileNumber'] as String?,
      panNumber: json['panNumber'] as String?,
      lastRefresh: json['lastRefresh'] as int?,
      currentAssetValue: (json['currentAssetValue'] as num?)?.toDouble(),
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      returnValue: (json['returnValue'] as num?)?.toDouble(),
      oneDayChange: (json['oneDayChange'] as num?)?.toDouble(),
      oneDayChangePercentage:
          (json['oneDayChangePercentage'] as num?)?.toDouble(),
      xirr: (json['xirr'] as num?)?.toDouble(),
      holdingsCount: json['holdingsCount'] as int?,
      returnPercentage: (json['returnPercentage'] as num?)?.toDouble(),
      equityPercentage: (json['equityPercentage'] as num?)?.toDouble(),
      debtPercentage: (json['debtPercentage'] as num?)?.toDouble(),
      hybridPercentage: (json['hybridPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ImportedHoldingUserToJson(
        ImportedHoldingUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'mobileNumber': instance.mobileNumber,
      'panNumber': instance.panNumber,
      'lastRefresh': instance.lastRefresh,
      'currentAssetValue': instance.currentAssetValue,
      'investedValue': instance.investedValue,
      'returnValue': instance.returnValue,
      'oneDayChange': instance.oneDayChange,
      'oneDayChangePercentage': instance.oneDayChangePercentage,
      'xirr': instance.xirr,
      'holdingsCount': instance.holdingsCount,
      'returnPercentage': instance.returnPercentage,
      'equityPercentage': instance.equityPercentage,
      'debtPercentage': instance.debtPercentage,
      'hybridPercentage': instance.hybridPercentage,
    };

HoldingDistribution _$HoldingDistributionFromJson(Map<String, dynamic> json) =>
    HoldingDistribution(
      id: json['id'] as int,
      userID: json['userID'] as int,
      brokerName: json['brokerName'] as String,
      currentAssetValue: (json['currentAssetValue'] as num?)?.toDouble(),
      currentInvestment: (json['currentInvestment'] as num?)?.toDouble(),
      currentReturns: (json['currentReturns'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HoldingDistributionToJson(
        HoldingDistribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'brokerName': instance.brokerName,
      'currentAssetValue': instance.currentAssetValue,
      'currentInvestment': instance.currentInvestment,
      'currentReturns': instance.currentReturns,
    };
