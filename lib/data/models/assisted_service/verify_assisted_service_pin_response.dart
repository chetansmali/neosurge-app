import 'package:json_annotation/json_annotation.dart';

part 'verify_assisted_service_pin_response.g.dart';

@JsonSerializable()
class UserDetailsId {
  final int id;
  final double amount;
  final String purchasedOn;
  final String expiresOn;
  final dynamic orderId;
  final bool isExpired;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  UserDetailsId({
    required this.id,
    required this.amount,
    required this.purchasedOn,
    required this.expiresOn,
    required this.orderId,
    required this.isExpired,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetailsId.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsIdFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsIdToJson(this);
}

@JsonSerializable()
class UserDTO {
  final UserDetailsId? assistedServiceUserDetailsId;

  UserDTO({
    this.assistedServiceUserDetailsId,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}

@JsonSerializable()
class VerifyAssistedServicePinResponse {
  final UserDTO userDTO;

  VerifyAssistedServicePinResponse({
    required this.userDTO,
  });

  factory VerifyAssistedServicePinResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyAssistedServicePinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAssistedServicePinResponseToJson(this);
}
