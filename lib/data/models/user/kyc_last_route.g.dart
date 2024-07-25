// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_last_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycLastRouteModel _$KycLastRouteModelFromJson(Map<String, dynamic> json) =>
    KycLastRouteModel(
      lastRoute: json['lastRoutedScreen'] as String?,
      kycCompliant: json['kycCompliant'] as bool,
      stepCount: json['stepCount'] as int,
      maxStepCount: json['maxStepCount'] as int,
    );

Map<String, dynamic> _$KycLastRouteModelToJson(KycLastRouteModel instance) =>
    <String, dynamic>{
      'lastRoutedScreen': instance.lastRoute,
      'kycCompliant': instance.kycCompliant,
      'stepCount': instance.stepCount,
      'maxStepCount': instance.maxStepCount,
    };
