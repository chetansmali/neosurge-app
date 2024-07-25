import 'package:json_annotation/json_annotation.dart';

part 'capture_faq_dislike_params.g.dart';

@JsonSerializable()
class CaptureFaqDislikeParams {
  final String faqId;
  final String dislikeReason;
  final String message;
  CaptureFaqDislikeParams({
    required this.faqId,
    required this.dislikeReason,
    required this.message,
  });

  factory CaptureFaqDislikeParams.fromJson(Map<String, dynamic> json) =>
      _$CaptureFaqDislikeParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CaptureFaqDislikeParamsToJson(this);
}
