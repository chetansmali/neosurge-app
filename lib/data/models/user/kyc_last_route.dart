import 'package:json_annotation/json_annotation.dart';

part 'kyc_last_route.g.dart';

@JsonSerializable()
class KycLastRouteModel {
  @JsonKey(name: 'lastRoutedScreen')
  String? lastRoute;
  final bool kycCompliant;
  final int stepCount;
  final int maxStepCount;

  KycLastRouteModel({
    this.lastRoute,
    required this.kycCompliant,
    required this.stepCount,
    required this.maxStepCount,
  });

  factory KycLastRouteModel.fromJson(Map<String, dynamic> json) =>
      _$KycLastRouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$KycLastRouteModelToJson(this);

  KycLastRouteModel copyWith({
    String? lastRoute,
    bool? kycCompliant,
    int? stepCount,
    int? maxStepCount,
  }) {
    return KycLastRouteModel(
      lastRoute: lastRoute ?? this.lastRoute,
      kycCompliant: kycCompliant ?? this.kycCompliant,
      stepCount: stepCount ?? this.stepCount,
      maxStepCount: maxStepCount ?? this.maxStepCount,
    );
  }
}
