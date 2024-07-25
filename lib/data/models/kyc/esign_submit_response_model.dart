import 'package:json_annotation/json_annotation.dart';

part 'esign_submit_response_model.g.dart';

@JsonSerializable()
class ESignSubmitResponseModel {
  @JsonKey(name: 'fpEsignRedirectUrl')
  final String fpESignRedirectUrl;

  ESignSubmitResponseModel({
    required this.fpESignRedirectUrl,
  });

  factory ESignSubmitResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ESignSubmitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ESignSubmitResponseModelToJson(this);
}
