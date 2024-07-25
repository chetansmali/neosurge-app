// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanUserDetails _$GetLoanUserDetailsFromJson(Map<String, dynamic> json) =>
    GetLoanUserDetails(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      loansImported: json['loansImported'] as bool?,
      mfImported: json['mfImported'] as bool?,
      loanInitiated: json['loanInitiated'] as bool?,
      creditPulled: json['creditPulled'] as bool?,
      loanPercentage: (json['loanPercentage'] as num?)?.toDouble(),
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GetLoanUserDetailsToJson(GetLoanUserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'loansImported': instance.loansImported,
      'mfImported': instance.mfImported,
      'loanInitiated': instance.loanInitiated,
      'creditPulled': instance.creditPulled,
      'loanPercentage': instance.loanPercentage,
      'credit_limit': instance.creditLimit,
    };
