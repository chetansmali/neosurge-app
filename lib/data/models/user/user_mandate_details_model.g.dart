// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mandate_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMandate _$UserMandateFromJson(Map<String, dynamic> json) => UserMandate(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as int,
      bankAccountId: json['bankAccountId'] as int?,
      mandateId: json['mandateId'] as int,
      mandateType: json['mandateType'] as String?,
      mandateLimit: (json['mandateLimit'] as num).toDouble(),
      mandateReference: json['mandateReference'] as String,
      tokenId: json['tokenId'] as int?,
      tokenUrl: json['tokenUrl'] as String?,
      status: $enumDecodeNullable(_$UserMandateStatusEnumMap, json['status']),
      isMailSent: json['isMailSent'] as bool,
      mandateToken: json['mandateToken'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
      rejectedReason: json['rejectedReason'] as String?,
      isDeleted: json['isDeleted'] as bool,
    );

Map<String, dynamic> _$UserMandateToJson(UserMandate instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'id': instance.id,
      'bankAccountId': instance.bankAccountId,
      'mandateId': instance.mandateId,
      'mandateType': instance.mandateType,
      'mandateLimit': instance.mandateLimit,
      'mandateReference': instance.mandateReference,
      'tokenId': instance.tokenId,
      'tokenUrl': instance.tokenUrl,
      'status': _$UserMandateStatusEnumMap[instance.status],
      'isMailSent': instance.isMailSent,
      'mandateToken': instance.mandateToken,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'rejectedReason': instance.rejectedReason,
      'isDeleted': instance.isDeleted,
    };

const _$UserMandateStatusEnumMap = {
  UserMandateStatus.failed: 'FAILED',
  UserMandateStatus.rejected: 'REJECTED',
  UserMandateStatus.received: 'RECEIVED',
  UserMandateStatus.submitted: 'SUBMITTED',
  UserMandateStatus.approved: 'APPROVED',
  UserMandateStatus.created: 'CREATED',
};
