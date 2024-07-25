// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_assisted_service_pin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsId _$UserDetailsIdFromJson(Map<String, dynamic> json) =>
    UserDetailsId(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      purchasedOn: json['purchasedOn'] as String,
      expiresOn: json['expiresOn'] as String,
      orderId: json['orderId'],
      isExpired: json['isExpired'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserDetailsIdToJson(UserDetailsId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'purchasedOn': instance.purchasedOn,
      'expiresOn': instance.expiresOn,
      'orderId': instance.orderId,
      'isExpired': instance.isExpired,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      assistedServiceUserDetailsId: json['assistedServiceUserDetailsId'] == null
          ? null
          : UserDetailsId.fromJson(
              json['assistedServiceUserDetailsId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'assistedServiceUserDetailsId': instance.assistedServiceUserDetailsId,
    };

VerifyAssistedServicePinResponse _$VerifyAssistedServicePinResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyAssistedServicePinResponse(
      userDTO: UserDTO.fromJson(json['userDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyAssistedServicePinResponseToJson(
        VerifyAssistedServicePinResponse instance) =>
    <String, dynamic>{
      'userDTO': instance.userDTO,
    };
