// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_init_loan_import_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInitiateLoanImportResponse _$GetInitiateLoanImportResponseFromJson(
        Map<String, dynamic> json) =>
    GetInitiateLoanImportResponse(
      questionKey: json['questionKey'] as String?,
      answerKey: json['answerKey'] as String?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$GetInitiateLoanImportResponseToJson(
        GetInitiateLoanImportResponse instance) =>
    <String, dynamic>{
      'questionKey': instance.questionKey,
      'answerKey': instance.answerKey,
      'accessToken': instance.accessToken,
    };
