// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsResponse _$AccountDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AccountDetailsResponse(
      phoneNumber: json['phoneNumber'] as String,
      panNumber: json['panNumber'] as String,
      hasImported: json['hasImported'] as bool,
      lastRefresh: json['lastRefresh'] as int?,
      refreshAvailable: json['refreshAvailable'] as bool,
    );

Map<String, dynamic> _$AccountDetailsResponseToJson(
        AccountDetailsResponse instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'panNumber': instance.panNumber,
      'hasImported': instance.hasImported,
      'lastRefresh': instance.lastRefresh,
      'refreshAvailable': instance.refreshAvailable,
    };
