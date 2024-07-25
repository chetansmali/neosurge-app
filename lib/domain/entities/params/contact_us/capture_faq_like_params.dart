import 'package:json_annotation/json_annotation.dart';

part 'capture_faq_like_params.g.dart';

@JsonSerializable()
class CaptureFaqLikeParams {
  final String id;
  CaptureFaqLikeParams({
    required this.id,
  });

  factory CaptureFaqLikeParams.fromJson(Map<String, dynamic> json) =>
      _$CaptureFaqLikeParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CaptureFaqLikeParamsToJson(this);
}
