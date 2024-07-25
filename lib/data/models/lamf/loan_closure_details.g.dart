// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_closure_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanClosureDetails _$LoanClosureDetailsFromJson(Map<String, dynamic> json) =>
    LoanClosureDetails(
      json['status'] as String,
      json['message'] as String,
      json['amount'] as int,
    );

Map<String, dynamic> _$LoanClosureDetailsToJson(LoanClosureDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'amount': instance.amount,
    };
