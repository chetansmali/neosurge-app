// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanDataResponse _$GetLoanDataResponseFromJson(Map<String, dynamic> json) =>
    GetLoanDataResponse(
      loanType: json['loanType'] as String?,
      startDate: json['startDate'] as String?,
      accountNumber: json['accountNumber'] as String?,
      lenderName: json['lenderName'] as String?,
      sanctionedAmount: (json['sanctionedAmount'] as num?)?.toDouble(),
      outstanding: (json['outstanding'] as num?)?.toDouble(),
      interest: (json['interest'] as num?)?.toDouble(),
      tenure: json['tenure'] as int?,
      isSecured: json['isSecured'] as bool?,
      loanStatus: json['loanStatus'] as String?,
      emi: (json['emi'] as num?)?.toDouble(),
      payments: json['payments'] == null
          ? null
          : GetLoanDataResponsePayments.fromJson(
              json['payments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetLoanDataResponseToJson(
        GetLoanDataResponse instance) =>
    <String, dynamic>{
      'loanType': instance.loanType,
      'startDate': instance.startDate,
      'accountNumber': instance.accountNumber,
      'lenderName': instance.lenderName,
      'sanctionedAmount': instance.sanctionedAmount,
      'outstanding': instance.outstanding,
      'interest': instance.interest,
      'tenure': instance.tenure,
      'isSecured': instance.isSecured,
      'loanStatus': instance.loanStatus,
      'emi': instance.emi,
      'payments': instance.payments,
    };

GetLoanDataResponsePayments _$GetLoanDataResponsePaymentsFromJson(
        Map<String, dynamic> json) =>
    GetLoanDataResponsePayments(
      totalPayments: json['totalPayments'] as int?,
      ontimePayments: json['ontimePayments'] as int?,
      delayedPayments: json['delayedPayments'] as int?,
    );

Map<String, dynamic> _$GetLoanDataResponsePaymentsToJson(
        GetLoanDataResponsePayments instance) =>
    <String, dynamic>{
      'totalPayments': instance.totalPayments,
      'ontimePayments': instance.ontimePayments,
      'delayedPayments': instance.delayedPayments,
    };
