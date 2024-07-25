import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/constants.dart';

part 'assisted_service_user_details.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeIds.assistedServiceUserDetailsTypeId)
class AssistedServiceUserDetails {
  //{
  //             "id": 1,
  //             "amount": 5000,
  //             "purchasedOn": null,
  //             "orderId": "abc",
  //             "isDeleted": false,
  //             "createdAt": "2022-09-30T07:45:59.000+00:00",
  //             "updatedAt": "2022-09-30T07:45:59.000+00:00",
  //             "is_expired": true
  //         },

  //"id": 19,
  //             "amount": 5000.0,
  //             "purchasedOn": "2022-10-17T00:00:00.000+00:00",
  //             "expiresOn": "2023-10-17T00:00:00.000+00:00",
  //             "orderId": "order_KUonaADzQGSbCB",
  //             "isExpired": false,
  //             "isDeleted": false,
  //             "createdAt": "2022-10-17T11:14:14.834+00:00",
  //             "updatedAt": "2022-10-17T11:14:14.834+00:00"

  @HiveField(0)
  final int id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime purchasedOn;
  @HiveField(3)
  final DateTime expiresOn;
  @HiveField(4)
  final String? orderId;
  @HiveField(5)
  final bool isExpired;
  @HiveField(6)
  final bool isDeleted;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final DateTime updatedAt;

  AssistedServiceUserDetails({
    required this.id,
    required this.amount,
    required this.purchasedOn,
    required this.orderId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.isExpired,
    required this.expiresOn,
  });

  factory AssistedServiceUserDetails.fromJson(Map<String, dynamic> json) =>
      _$AssistedServiceUserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AssistedServiceUserDetailsToJson(this);
}
