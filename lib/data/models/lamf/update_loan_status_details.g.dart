// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_loan_status_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLoanStatusDetails _$UpdateLoanStatusDetailsFromJson(
        Map<String, dynamic> json) =>
    UpdateLoanStatusDetails(
      message: json['message'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpdateLoanStatusDetailsToJson(
        UpdateLoanStatusDetails instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
