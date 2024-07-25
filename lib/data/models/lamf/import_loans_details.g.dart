// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_loans_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportLoansDetails _$ImportLoansDetailsFromJson(Map<String, dynamic> json) =>
    ImportLoansDetails(
      userID: json['userID'] as int,
      activeLoans: json['activeLoans'] as String,
      sanctionAmount: json['sanctionAmount'] as String,
      amountPending: json['amountPending'] as String,
      totalEMI: json['totalEMI'] as String,
      amountRepaid: json['amountRepaid'] as String,
    );

Map<String, dynamic> _$ImportLoansDetailsToJson(ImportLoansDetails instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'activeLoans': instance.activeLoans,
      'sanctionAmount': instance.sanctionAmount,
      'amountPending': instance.amountPending,
      'totalEMI': instance.totalEMI,
      'amountRepaid': instance.amountRepaid,
    };
