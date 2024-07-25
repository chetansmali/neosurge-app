// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_data_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanDataDetails _$GetLoanDataDetailsFromJson(Map<String, dynamic> json) =>
    GetLoanDataDetails(
      cashWithdrawn: (json['cashWithdrawn'] as num).toDouble(),
      cashAvailable: (json['cashAvailable'] as num).toDouble(),
      creditLimit: (json['creditLimit'] as num).toDouble(),
      pledgedCount: json['pledgedCount'] as int,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetLoanDataDetailsToJson(GetLoanDataDetails instance) =>
    <String, dynamic>{
      'cashWithdrawn': instance.cashWithdrawn,
      'cashAvailable': instance.cashAvailable,
      'creditLimit': instance.creditLimit,
      'pledgedCount': instance.pledgedCount,
      'transactions': instance.transactions,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      date: json['date'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'date': instance.date,
      'amount': instance.amount,
      'description': instance.description,
    };
