import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'user_mandate_details_model.g.dart';

@JsonSerializable()
class UserMandate {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final int? bankAccountId;
  final int mandateId;
  final String? mandateType;
  final double mandateLimit;
  final String mandateReference;
  final int? tokenId;
  final String? tokenUrl;
  final UserMandateStatus? status;
  final bool isMailSent;
  final String? mandateToken;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final String? rejectedReason;
  final bool isDeleted;

  UserMandate({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.bankAccountId,
    required this.mandateId,
    this.mandateType,
    required this.mandateLimit,
    required this.mandateReference,
    this.tokenId,
    this.tokenUrl,
    this.status,
    required this.isMailSent,
    this.mandateToken,
    this.approvedAt,
    this.rejectedAt,
    this.rejectedReason,
    required this.isDeleted,
  });

  factory UserMandate.fromJson(Map<String, dynamic> json) =>
      _$UserMandateFromJson(json);

  Map<String, dynamic> toJson() => _$UserMandateToJson(this);
}
