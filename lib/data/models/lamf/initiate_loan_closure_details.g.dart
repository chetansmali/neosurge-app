// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_loan_closure_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateLoanClosureDetails _$InitiateLoanClosureDetailsFromJson(
        Map<String, dynamic> json) =>
    InitiateLoanClosureDetails(
      loanClosable: json['loanClosable'] as bool,
      outstanding: json['outstanding'] as int,
    );

Map<String, dynamic> _$InitiateLoanClosureDetailsToJson(
        InitiateLoanClosureDetails instance) =>
    <String, dynamic>{
      'outstanding': instance.outstanding,
      'loanClosable': instance.loanClosable,
    };
