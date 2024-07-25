// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transactions_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionsDetails _$GetTransactionsDetailsFromJson(
        Map<String, dynamic> json) =>
    GetTransactionsDetails(
      Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTransactionsDetailsToJson(
        GetTransactionsDetails instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      amount: json['amount'] as int,
      date: json['date'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'amount': instance.amount,
      'date': instance.date,
      'description': instance.description,
    };
