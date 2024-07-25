// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_faq_dislike_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptureFaqDislikeParams _$CaptureFaqDislikeParamsFromJson(
        Map<String, dynamic> json) =>
    CaptureFaqDislikeParams(
      faqId: json['faqId'] as String,
      dislikeReason: json['dislikeReason'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CaptureFaqDislikeParamsToJson(
        CaptureFaqDislikeParams instance) =>
    <String, dynamic>{
      'faqId': instance.faqId,
      'dislikeReason': instance.dislikeReason,
      'message': instance.message,
    };
