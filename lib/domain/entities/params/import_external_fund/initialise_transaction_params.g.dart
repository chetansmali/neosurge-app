// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialise_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitialiseTransactionParams _$InitialiseTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    InitialiseTransactionParams(
      userID: json['userID'] as int,
      panNumber: json['panNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$InitialiseTransactionParamsToJson(
        InitialiseTransactionParams instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'panNumber': instance.panNumber,
      'phoneNumber': instance.phoneNumber,
    };
